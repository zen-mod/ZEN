#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns SQF code that can be executed to restore the current mission.
 * Players and dead objects are ignored.
 *
 * Arguments:
 * 0: Position <ARRAY> (default: [0, 0, 0])
 * 1: Radius <NUMBER> (default: -1)
 *   - in meters, -1 for entire mission
 * 2: Include Waypoints <BOOL> (default: true)
 * 3: Include Markers <BOOL> (default: false)
 * 4: Curator Editable Objects Only <BOOL> (default: false)
 *
 * Return Value:
 * Mission SQF <STRING>
 *
 * Example:
 * [] call zen_common_fnc_exportMissionSQF
 *
 * Public: No
 */

#define FORMAT_OBJ_VAR(index) format ["_object%1", index]
#define FORMAT_GRP_VAR(index) format ["_group%1", index]

#define NEWLINE toString [ASCII_NEWLINE]

params [
    ["_position", [0, 0, 0], [[]], [2, 3]],
    ["_radius", -1, [0]],
    ["_includeWaypoints", true, [true]],
    ["_includeMarkers", false, [true]],
    ["_editableOnly", false, [true]]
];

// Keep track of all processed objects and groups, their index in their corresponding array
// is used to determine the variable name used in the exported SQF
private _processedObjects = [];
private _processedGroups = [];

// Separate the exported SQF into different sections, this is used to ensure the correct
// ordering of the output (for example, applying group properties after all units are created)
private _outputGroups1 = [];
private _outputObjects = [];
private _outputGroups2 = [];
private _outputCrew = [];
private _outputCargo = [];
private _outputSlingLoad = [];
private _outputAttach = [];
private _outputMarkers = [];

private _fnc_processGroup = {
    params ["_group"];

    if (_group isEqualType objNull) then {
        _group = group _group;
    };

    private _index = _processedGroups find _group;

    if (_index == -1) then {
        _index = _processedGroups pushBack _group;

        private _varName = FORMAT_GRP_VAR(_index);

        private _sideName = ["east", "west", "independent", "civilian"] select (side _group call BIS_fnc_sideID);
        _outputGroups1 pushBack ["%1 = createGroup [%2, true];", _varName, _sideName];

        _outputGroups2 pushBack ["%1 setFormation %2;", _varName, str formation _group];
        _outputGroups2 pushBack ["%1 setBehaviour %2;", _varName, str behaviour leader _group];
        _outputGroups2 pushBack ["%1 setCombatMode %2;", _varName, str combatMode _group];
        _outputGroups2 pushBack ["%1 setSpeedMode %2;", _varName, str speedMode _group];

        if (_includeWaypoints) then {
            _outputGroups2 pushBack "";

            {
                if (_forEachIndex == 0) then {
                    _outputGroups2 pushBack ["_waypoint = [%1, 0];", _varName];
                } else {
                    _outputGroups2 pushBack ["_waypoint = %1 addWaypoint [[0, 0, 0], -1];", _varName];
                };

                _outputGroups2 pushBack ["_waypoint setWaypointPosition [%1, -1];", AGLtoASL waypointPosition _x];
                _outputGroups2 pushBack ["_waypoint setWaypointType %1;", str waypointType _x];
                _outputGroups2 pushBack ["_waypoint setWaypointName %1;", str waypointName _x];
                _outputGroups2 pushBack ["_waypoint setWaypointDescription %1;", str waypointDescription _x];
                _outputGroups2 pushBack ["_waypoint setWaypointFormation %1;", str waypointFormation _x];
                _outputGroups2 pushBack ["_waypoint setWaypointBehaviour %1;", str waypointBehaviour _x];
                _outputGroups2 pushBack ["_waypoint setWaypointCombatMode %1;", str waypointCombatMode _x];
                _outputGroups2 pushBack ["_waypoint setWaypointSpeed %1;", str waypointSpeed _x];
                _outputGroups2 pushBack ["_waypoint setWaypointTimeout %1;", waypointTimeout _x];
                _outputGroups2 pushBack ["_waypoint setWaypointCompletionRadius %1;", waypointCompletionRadius _x];
                _outputGroups2 pushBack ["_waypoint setWaypointStatements %1;", waypointStatements _x];
                _outputGroups2 pushBack ["_waypoint setWaypointScript %1;", str waypointScript _x];

                _outputGroups2 pushBack "";
            } forEach waypoints _group;

            _outputGroups2 pushBack ["%1 setCurrentWaypoint [%1, %2];", _varName, currentWaypoint _group];
        };

        _outputGroups2 pushBack "";
    };

    _index
};

private _fnc_processInventory = {
    params ["_object", "_varName"];

    if (_object isKindOf "CAManBase") then {
        private _nextFrameHandle = format ["%1_nextFrameHandle", _varName];
        _outputObjects pushBack ["['%1', 'onEachFrame', {", _nextFrameHandle];
        _outputObjects pushBack "    params [""_unit""];";
        if !(_object call FUNC(hasDefaultInventory)) then {
            _outputObjects pushBack ["    _unit setUnitLoadout %1;", getUnitLoadout _object];
        };
        _outputObjects pushBack "    _unit call BIN_fnc_CBRNHoseInit;";
        _outputObjects pushBack ["    ['%1', 'onEachFrame'] call BIS_fnc_removeStackedEventHandler;", _nextFrameHandle];
        _outputObjects pushBack ["}, [%1]] call BIS_fnc_addStackedEventHandler;", _varName];
    } else {
        if (_object call FUNC(hasDefaultInventory)) exitWith {};

        private _fnc_processCargo = {
            params ["_cargo", "_command"];
            _cargo params ["_types", "_counts"];

            if (_cargo isEqualTo [[], []]) exitWith {};

            // Convert cargo array format from [[type1, ..., typeN], [count1, ..., countN]] to [[type1, count1], ..., [typeN, countN]]
            _cargo = [];

            {
                _cargo pushBack [_x, _counts select _forEachIndex];
            } forEach _types;

            _outputObjects pushBack ["{%1 %2 _x} forEach %3;", _varName, _command, _cargo];
        };

        _outputObjects pushBack "";
        _outputObjects pushBack ["clearItemCargoGlobal %1;", _varName];
        _outputObjects pushBack ["clearWeaponCargoGlobal %1;", _varName];
        _outputObjects pushBack ["clearMagazineCargoGlobal %1;", _varName];
        _outputObjects pushBack ["clearBackpackCargoGlobal %1;", _varName];
        _outputObjects pushBack "";

        {
            _x call _fnc_processCargo;
        } forEach [
            [getItemCargo _object, "addItemCargoGlobal"],
            [getWeaponCargo _object, "addWeaponCargoGlobal"],
            [getMagazineCargo _object, "addMagazineCargoGlobal"],
            [getBackpackCargo _object, "addBackpackCargoGlobal"]
        ];
    };

    _outputObjects pushBack "";
};

private _fnc_processAttachedObjects = {
    params ["_object", "_parentVarName"];

    {
        // Filter vehicle cargo objects, they are also attached
        if (alive _x && {!isPlayer _x} && {isNull isVehicleCargo _x}) then {
            private _index = _x call _fnc_processObject;
            if (isNil "_index") exitWith {};

            private _varName = FORMAT_OBJ_VAR(_index);
            private _offset = _object worldToModel ASLtoAGL getPosASL _x;
            private _dirAndUp = [_object vectorWorldToModel vectorDir _x, _object vectorWorldToModel vectorUp _x];

            _outputAttach pushBack ["%1 attachTo [%2, %3];", _varName, _parentVarName, _offset];
            _outputAttach pushBack ["%1 setVectorDirAndUp %2;", _varName, _dirAndUp];
        };
    } forEach attachedObjects _object;
};

private _fnc_processUnit = {
    params ["_unit"];

    private _index = _processedObjects find _unit;

    if (_index == -1) then {
        _index = _processedObjects pushBack _unit;

        private _groupVarName = FORMAT_GRP_VAR(_unit call _fnc_processGroup);
        private _varName = FORMAT_OBJ_VAR(_index);

        _outputObjects pushBack ["%1 = %2 createUnit [%3, [0, 0, 0], [], 0, ""CAN_COLLIDE""];", _varName, _groupVarName, str typeOf _unit];
        _outputObjects pushBack ["%1 setPosASL %2;", _varName, getPosASL _unit];
        _outputObjects pushBack ["%1 setDir %2;", _varName, getDir _unit];
        _outputObjects pushBack ["%1 setRank %2;", _varName, str rank _unit];
        _outputObjects pushBack ["%1 setSkill %2;", _varName, skill _unit];
        _outputObjects pushBack ["%1 setUnitPos %2;", _varName, str unitPos _unit];

        private _flagTexture = getForcedFlagTexture _unit;

        if (_flagTexture != "") then {
            _outputObjects pushBack ["%1 forceFlagTexture %2;", _varName, str _flagTexture];
        };

        if (leader _unit == _unit) then {
            _outputObjects pushBack ["%1 selectLeader %2;", _groupVarName, _varName];
        };

        [_unit, _varName] call _fnc_processInventory;
        [_unit, _varName] call _fnc_processAttachedObjects;

        _outputObjects pushBack "";
    };

    _index
};

private _fnc_processVehicle = {
    params ["_vehicle"];

    private _index = _processedObjects find _vehicle;

    if (_index == -1) then {
        _index = _processedObjects pushBack _vehicle;

        private _varName = FORMAT_OBJ_VAR(_index);
        private _placement = ["CAN_COLLIDE", "FLY"] select (_vehicle isKindOf "Air" && {isEngineOn _vehicle} && {getPos _vehicle select 2 > 5});

        _outputObjects pushBack ["%1 = createVehicle [%2, [0, 0, 0], [], 0, %3];", _varName, str typeOf _vehicle, str _placement];
        _outputObjects pushBack ["%1 setVectorDirAndUp %2;", _varName, [vectorDir _vehicle, vectorUp _vehicle]];
        _outputObjects pushBack ["%1 setPosASL %2;", _varName, getPosASL _vehicle];

        private _fuel = fuel _vehicle;

        if (_fuel < 1) then {
            _outputObjects pushBack ["%1 setFuel %2;", _varName, _fuel];
        };

        private _damage = damage _vehicle;

        if (_damage > 0) then {
            _outputObjects pushBack ["%1 setDamage %2;", _varName, _damage];
        };

        private _hitPointsDamage = getAllHitPointsDamage _vehicle param [2, []];

        if (_hitPointsDamage findIf {_x > 0} != -1) then {
            _outputObjects pushBack ["{%1 setHitIndex [_forEachIndex, _x, false]} forEach %2;", _varName, _hitPointsDamage];
        };

        private _flagTexture = getForcedFlagTexture _vehicle;

        if (_flagTexture != "") then {
            _outputObjects pushBack ["%1 forceFlagTexture %2;", _varName, str _flagTexture];
        };

        (_vehicle call BIS_fnc_getVehicleCustomization) params ["_textures", "_animations"];
        _outputObjects pushBack ["[%1, %2, %3, true] call BIS_fnc_initVehicle;", _varName, _textures, _animations];

        [_vehicle, _varName] call _fnc_processInventory;

        private _pylonMagazines = getPylonMagazines _vehicle;

        private _turretMagazines = magazinesAllTurrets _vehicle select {
            !(_x select 0 in _pylonMagazines) // Do not include pylon magazines
        } apply {
            _x select [0, 3] // Discard ID and creator
        };

        _outputObjects pushBack ["{%1 removeMagazineTurret (_x select [0, 2])} forEach magazinesAllTurrets %1;", _varName];
        _outputObjects pushBack ["{%1 addMagazineTurret _x} forEach %2;", _varName, _turretMagazines];

        {
            private _pylonIndex = _forEachIndex + 1;
            private _turretPath = [_vehicle, _forEachIndex] call FUNC(getPylonTurret);
            private _ammoCount = _vehicle ammoOnPylon _pylonIndex;

            _outputObjects pushBack ["%1 setPylonLoadOut [%2, %3, false, %4];", _varName, _pylonIndex, str _x, _turretPath];
            _outputObjects pushBack ["%1 setAmmoOnPylon [%2, %3];", _varName, _pylonIndex, _ammoCount];
        } forEach _pylonMagazines;

        {
            _x params ["_unit", "_role", "_cargoIndex", "_turretPath"];

            if (alive _unit && {!isPlayer _unit}) then {
                private _index = _unit call _fnc_processUnit;
                if (isNil "_index") exitWith {};

                private _unitVarName = FORMAT_OBJ_VAR(_index);

                switch (toLower _role) do {
                    case "driver": {
                        // moveInDriver does not work for virtual UAV crew, moveInAny does
                        if (getText (configOf _unit >> "simulation") == "UAVPilot") then {
                            _outputCrew pushBack ["%1 moveInAny %2;", _unitVarName, _varName];
                        } else {
                            _outputCrew pushBack ["%1 moveInDriver %2;", _unitVarName, _varName];
                        };
                    };
                    case "commander": {
                        _outputCrew pushBack ["%1 moveInCommander %2;", _unitVarName, _varName];
                    };
                    case "gunner": {
                        _outputCrew pushBack ["%1 moveInGunner %2;", _unitVarName, _varName];
                    };
                    case "turret": {
                        _outputCrew pushBack ["%1 moveInTurret [%2, %3];", _unitVarName, _varName, _turretPath];
                    };
                    case "cargo": {
                        _outputCrew pushBack ["%1 moveInCargo [%2, %3];", _unitVarName, _varName, _cargoIndex];
                        _outputCrew pushBack ["%1 assignAsCargoIndex [%2, %3];", _unitVarName, _varName, _cargoIndex];
                    };
                };
            };
        } forEach fullCrew _vehicle;

        {
            if (alive _x) then {
                private _index = _x call _fnc_processObject;
                if (isNil "_index") exitWith {};

                _outputCargo pushBack ["%1 setVehicleCargo %2;", _varName, FORMAT_OBJ_VAR(_index)];
            };
        } forEach getVehicleCargo _vehicle;

        private _slingLoadedObject = getSlingLoad _vehicle;

        if (alive _slingLoadedObject) then {
            private _index = _slingLoadedObject call _fnc_processObject;
            if (isNil "_index") exitWith {};

            _outputSlingLoad pushBack ["%1 setSlingLoad %2;", _varName, FORMAT_OBJ_VAR(_index)];
        };

        [_vehicle, _varName] call _fnc_processAttachedObjects;
    };

    _index
};

private _fnc_processStatic = {
    params ["_object"];

    private _index = _processedObjects find _object;

    if (_index == -1) then {
        _index = _processedObjects pushBack _object;

        private _varName = FORMAT_OBJ_VAR(_index);

        _outputObjects pushBack ["%1 = createVehicle [%2, [0, 0, 0], [], 0, ""CAN_COLLIDE""];", _varName, str typeOf _object];
        _outputObjects pushBack ["%1 setVectorDirAndUp %2;", _varName, [vectorDir _object, vectorUp _object]];
        _outputObjects pushBack ["%1 setPosASL %2;", _varName, getPosASL _object];

        private _damage = damage _object;

        if (_damage > 0) then {
            _outputObjects pushBack ["%1 setDamage %2;", _varName, _damage];
        };

        [_object, _varName] call _fnc_processInventory;
        [_object, _varName] call _fnc_processAttachedObjects;

        _outputObjects pushBack "";
    };

    _index
};

private _fnc_processObject = {
    params ["_object"];

    if (_object isKindOf "AllVehicles") then {
        if (_object isKindOf "CAManBase") then {
            _object call _fnc_processUnit
        } else {
            if (_object isKindOf "Animal") exitWith {};
            _object call _fnc_processVehicle
        };
    } else {
        if (_object isKindOf "Static" || {_object isKindOf "Thing"}) then {
            if (_object isKindOf "ThingEffect") exitWith {};
            _object call _fnc_processStatic
        };
    };
};

private _objects = if (_editableOnly) then {
    curatorEditableObjects getAssignedCuratorLogic player
} else {
    allMissionObjects "All"
};

if (_radius > 0) then {
    _objects = _objects inAreaArray [_position, _radius, _radius, 0, false, -1];
};

{
    if (
        alive _x
        && {!isPlayer _x}
        && {isNull attachedTo _x}
        && {isNull ropeAttachedTo _x}
    ) then {
        _x call _fnc_processObject
    };
} forEach _objects;

if (_includeMarkers) then {
    {
        if (markerShape _x != "POLYLINE") then {
            _outputMarkers pushBack ["_marker = createMarker [%1, %2];", str _x, markerPos [_x, true]];
            _outputMarkers pushBack ["_marker setMarkerDir %1;", markerDir _x];
            _outputMarkers pushBack ["_marker setMarkerType %1;", str markerType _x];
            _outputMarkers pushBack ["_marker setMarkerShape %1;", str markerShape _x];
            _outputMarkers pushBack ["_marker setMarkerSize %1;", markerSize _x];
            _outputMarkers pushBack ["_marker setMarkerText %1;", str markerText _x];
            _outputMarkers pushBack ["_marker setMarkerBrush %1;", str markerBrush _x];
            _outputMarkers pushBack ["_marker setMarkerColor %1;", str markerColor _x];
            _outputMarkers pushBack ["_marker setMarkerAlpha %1;", markerAlpha _x];
            _outputMarkers pushBack "";
        };
    } forEach allMapMarkers;
};

private _output = "";

{

    if !(_x isEqualTo []) then {
        _x = _x apply {if (_x isEqualType []) then {format _x} else {_x}};
        _output = _output + (_x joinString NEWLINE) + NEWLINE + NEWLINE;
    };
} forEach [_outputGroups1, _outputObjects, _outputGroups2, _outputCrew, _outputCargo, _outputSlingLoad, _outputAttach, _outputMarkers];

_output
