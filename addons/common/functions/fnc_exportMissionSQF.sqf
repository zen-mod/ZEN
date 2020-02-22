#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns SQF code that can be executed to restore the current mission.
 *
 * Arguments:
 * 0: Position <ARRAY> (default: [0, 0, 0])
 * 1: Radius <NUMBER> (default: -1)
 *   - in meters, -1 for entire mission
 * 2: Include Waypoints <BOOL> (default: true)
 * 3: Include Markers <BOOL> (default: false)
 * 4: Add To Curators <BOOL> (default: false)
 *
 * Return Value:
 * Mission SQF <STRING>
 *
 * Example:
 * [] call zen_common_fnc_exportMissionSQF
 *
 * Public: No
 */

#define NEWLINE toString [ASCII_NEWLINE]

#define VAR_OBJECT(index) format ["_object%1", index]
#define VAR_GROUP(index) format ["_group%1", index]

params [
    ["_position", [0, 0, 0], [[]], [2, 3]],
    ["_radius", -1, [0]],
    ["_includeWaypoints", true, [true]],
    ["_includeMarkers", false, [true]],
    ["_addToCurators", false, [true]]
];

private _processedObjects = [];
private _processedGroups  = [];

private _outputGroups1   = [];
private _outputObjects   = [];
private _outputGroups2   = [];
private _outputCrew      = [];
private _outputCargo     = [];
private _outputSlingload = [];
private _outputAttach    = [];
private _outputMarkers   = [];

private _fnc_processGroup = {
    params ["_group"];

    if (_group isEqualType objNull) then {
        _group = group _group;
    };

    private _index = _processedGroups find _group;

    if (_index == -1) then {
        _index = _processedGroups pushBack _group;

        private _groupVar = VAR_GROUP(_index);
        private _sideName = ["east", "west", "independent", "civilian"] select (side _group call BIS_fnc_sideID);

        _outputGroups1 pushBack ["%1 = createGroup [%2, true];", _groupVar, _sideName];

        _outputGroups2 pushBack ["%1 setFormation %2;", _groupVar, str formation _group];
        _outputGroups2 pushBack ["%1 setBehaviour %2;", _groupVar, str behaviour leader _group];
        _outputGroups2 pushBack ["%1 setCombatMode %2;", _groupVar, str combatMode _group];
        _outputGroups2 pushBack ["%1 setSpeedMode %2;", _groupVar, str speedMode _group];

        if (_includeWaypoints) then {
            _outputGroups2 pushBack "";

            {
                if (_forEachIndex == 0) then {
                    _outputGroups2 pushBack ["_waypoint = [%1, 0];", _groupVar];
                } else {
                    _outputGroups2 pushBack ["_waypoint = %1 addWaypoint [[0, 0, 0], -1];", _groupVar];
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

            _outputGroups2 pushBack ["%1 setCurrentWaypoint [%1, %2];", _groupVar, currentWaypoint _group];
        };

        _outputGroups2 pushBack "";
    };

    _index
};

private _fnc_processInventory = {
    params ["_object", "_varName"];

    if (_object call FUNC(hasDefaultInventory)) exitWith {};

    if (_object isKindOf "CAManBase") exitWith {
        _outputObjects pushBack ["%1 setUnitLoadout %2;", _varName, getUnitLoadout _object];
    };

    _outputObjects pushBack "";
    _outputObjects pushBack ["clearItemCargoGlobal %1;", _varName];
    _outputObjects pushBack ["clearWeaponCargoGlobal %1;", _varName];
    _outputObjects pushBack ["clearMagazineCargoGlobal %1;", _varName];
    _outputObjects pushBack ["clearBackpackCargoGlobal %1;", _varName];
    _outputObjects pushBack "";

    // Converts cargo array format from [[type1, ... typeN], [count1, ... countN]] to [[type1, count1], ..., [typeN, countN]]
    private _fnc_convert = {
        params ["_types", "_counts"];

        private _cargo = [];

        {
            _cargo pushBack [_x, _counts select _forEachIndex];
        } forEach _types;

        _cargo
    };

    {
        _x params ["_cargo", "_command"];

        if !(_cargo isEqualTo [[], []]) then {
            _outputObjects pushBack ["{%1 %2 _x} forEach %3;", _varName, _command, _cargo call _fnc_convert];
        };
    } forEach [
        [getItemCargo _object, "addItemCargoGlobal"],
        [getWeaponCargo _object, "addWeaponCargoGlobal"],
        [getMagazineCargo _object, "addMagazineCargoGlobal"],
        [getBackpackCargo _object, "addBackpackCargoGlobal"]
    ];

    _outputObjects pushBack "";
};

private _fnc_processAttachedObjects = {
    params ["_object", "_parentVarName"];

    {
        // Array returned by attachedObjects can contained objNull
        if (!isNull _x && {isNull isVehicleCargo _x}) then {
            private _varName = VAR_OBJECT(_x call _fnc_processObject);

            _outputAttach pushBack ["%1 attachTo [%2, %3];", _varName, _parentVarName, _object worldToModel ASLtoAGL getPosASL _x];
            _outputAttach pushBack ["%1 setVectorDirAndUp %2;", _varName, [vectorDir _x, vectorUp _x]];
            _outputAttach pushBack "";
        };
    } forEach attachedObjects _object;
};

private _fnc_processUnit = {
    params ["_unit"];

    private _index = _processedObjects find _unit;

    if (_index == -1) then {
        _index = _processedObjects pushBack _unit;

        private _groupVarName = VAR_GROUP(_unit call _fnc_processGroup);
        private _varName = VAR_OBJECT(_index);

        _outputObjects pushBack ["%1 = %2 createUnit [%3, %4, [], 0, ""CAN_COLLIDE""];", _varName, _groupVarName, str typeOf _unit, getPosATL _unit];
        _outputObjects pushBack ["%1 setDir %2;", _varName, getDir _unit];
        _outputObjects pushBack ["%1 setRank %2;", _varName, str rank _unit];
        _outputObjects pushBack ["%1 setSkill %2;", _varName, skill _unit];
        _outputObjects pushBack ["%1 setUnitPos %2;", _varName, str unitPos _unit];

        if (getForcedFlagTexture _unit != "") then {
            _outputObjects pushBack ["%1 forceFlagTexture %2;", _varName, str getForcedFlagTexture _unit];
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

        private _varName = VAR_OBJECT(_index);

        private _placement = if (_vehicle isKindOf "Air" && {isEngineOn _vehicle} && {getPos _vehicle select 2 > 5}) then {
            "FLY"
        } else {
            "CAN_COLLIDE"
        };

        _outputObjects pushBack ["%1 = createVehicle [%2, [0, 0, 0], [], 0, %3];", _varName, str typeOf _vehicle, str _placement];
        _outputObjects pushBack ["%1 setVectorDirAndUp %2;", _varName, [vectorDir _vehicle, vectorUp _vehicle]];
        _outputObjects pushBack ["%1 setPosASL %2;", _varName, getPosASL _vehicle];
        _outputObjects pushBack ["%1 setDamage %2;", _varName, damage _vehicle];
        _outputObjects pushBack ["%1 setFuel %2;", _varName, fuel _vehicle];

        _outputObjects pushBack ["{%1 setHitIndex [_forEachIndex, _x, false]} forEach %2;", _varName, getAllHitPointsDamage _vehicle select 2];

        [_vehicle, _varName] call _fnc_processInventory;

        (_vehicle call BIS_fnc_getVehicleCustomization) params ["_textures", "_animations"];
        _outputObjects pushBack ["[%1, %2, %3, true] call BIS_fnc_initVehicle;", _varName, _textures, _animations];

        private _pylonMagazines = getPylonMagazines _vehicle;

        private _turretMagazines = magazinesAllTurrets _vehicle select {
            !(_x select 0 in _pylonMagazines) // Do not include pylon magazines
        } apply {
            _x select [0, 3] // Discard ID and creator
        };

        {
            private _turretPath = [_vehicle, _forEachIndex] call FUNC(getPylonTurret);
            private _ammoCount = _vehicle ammoOnPylon (_forEachIndex + 1);

            _pylonMagazines set [_forEachIndex, [_x, _turretPath, _ammoCount]];
        } forEach _pylonMagazines;

        _outputObjects pushBack ["{%1 removeMagazineTurret (_x select [0, 2])} forEach magazinesAllTurrets %1;", _varName];
        _outputObjects pushBack ["{%1 addMagazineTurret _x} forEach %2;", _varName, _turretMagazines];
        _outputObjects pushBack ["{%1 setPylonLoadOut [_forEachIndex + 1, _x select 1, false, _x select 1]; %1 setAmmoOnPylon [_forEachIndex + 1, _x select 2]} forEach %2;", _varName, _pylonMagazines];

        {
            _x params ["_unit", "_role", "_cargoIndex", "_turretPath"];

            private _unitVarName = VAR_OBJECT(_unit call _fnc_processUnit);

            switch (toLower _role) do {
                case "driver": {
                    // moveInDriver does not work for virtual UAV crew, moveInAny does
                    if (getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") == "UAVPilot") then {
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
        } forEach fullCrew _vehicle;

        {
            private _cargoVarName = VAR_OBJECT(_x call _fnc_processObject);
            _outputCargo pushBack ["%1 setVehicleCargo %2;", _varName, _cargoVarName];
        } forEach getVehicleCargo _vehicle;

        if (!isNull getSlingLoad _vehicle) then {
            private _slingloadVarName = VAR_OBJECT(getSlingLoad _vehicle call _fnc_processObject);
            _outputSlingload pushBack ["%1 setSlingLoad %2;", _varName, _slingloadVarName]
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

        private _varName = VAR_OBJECT(_index);

        _outputObjects pushBack ["%1 = createVehicle [%2, [0, 0, 0], [], 0, ""CAN_COLLIDE""];", _varName, str typeOf _object, getPosATL _object];
        _outputObjects pushBack ["%1 setVectorDirAndUp %2;", _varName, [vectorDir _object, vectorUp _object]];
        _outputObjects pushBack ["%1 setPosASL %2;", _varName, getPosASL _object];
        _outputObjects pushBack ["%1 setDamage %2;", _varName, damage _object];

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
            _object call _fnc_processVehicle
        };
    } else {
        if (_object isKindOf "Thing" || {_object isKindOf "Static"}) then {
            _object call _fnc_processStatic
        };
    };
};

private _objects = allMissionObjects "All";

if (_radius > 0) then {
    _objects = _objects inAreaArray [_position, _radius, _radius, 0, false, -1];
};

{
    if (
        alive _x
        && {!isPlayer _x}
        && {isNull attachedTo _x}
        && {isNull isVehicleCargo _x}
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

if (_addToCurators) then {
    // todo
};

private _output = "";

{

    if !(_x isEqualTo []) then {
        _x = _x apply {if (_x isEqualType []) then {format _x} else {_x}};
        _output = _output + (_x joinString NEWLINE) + NEWLINE + NEWLINE;
    };
} forEach [_outputGroups1, _outputObjects, _outputGroups2, _outputCrew, _outputCargo, _outputSlingload, _outputAttach, _outputMarkers];

_output
