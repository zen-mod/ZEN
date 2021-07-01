#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates objects based on the given serialized object data.
 * Object positions are calculated from their offsets relative to the center position.
 *
 * Arguments:
 * 0: Serialized Data <ARRAY>
 * 1: Center Position <ARRAY>
 * 2: Make Editable <BOOL> (default: true)
 * 3: Randomization <BOOL> (default: false)
 * 4: Use Headless Client <BOOL> (default: true)
 *
 * Return Value:
 * Created Objects <ARRAY>
 *
 * Example:
 * [_serializedData, _position] call zen_common_fnc_deserializeObjects
 *
 * Public: No
 */

params [["_serializedData", [], [[]]], ["_centerPos", [0, 0, 0], [[]], [2, 3]], ["_makeEditable", true, [true]], ["_enableRandomization", false, [true]], ["_useHC", true, [true]]];
_serializedData params [["_objectData", [], [[]]], ["_groupData", [], [[]]]];

// Check for suitable Headless Client
private _hc = [] call FUNC(getFewestGroupsHC);
if (isServer && {_useHC} && {!isNull _hc}) exitWith {
    [QEGVAR(common,deserializeObjects), _this, _hc] call CBA_fnc_targetEvent;
};

// Set center position to ground level over land and water level over the ocean
// Serialized object data offsets are relative to AGL height 0
_centerPos set [2, 0];

private _objects = [];
private _groups = createHashMap;

private _fnc_deserializeGroup = {
    params ["_index"];

    private _group = _groups get _index;

    if (isNil "_group") then {
        (_groupData select _index) params ["_side", "_formation", "_behaviour", "_combatMode", "_speedMode", "_waypoints", "_currentWaypoint"];

        _group = createGroup [_side, true];

        // Apply group properties and waypoints after units are created
        [{
            params ["_centerPos", "_group", "_formation", "_behaviour", "_combatMode", "_speedMode", "_waypoints", "_currentWaypoint"];

            _group setFormation _formation;
            _group setBehaviour _behaviour;
            _group setCombatMode _combatMode;
            _group setSpeedMode _speedMode;

            if (_waypoints isEqualTo []) exitWith {};

            // Delete the group's "default" waypoint
            deleteWaypoint [_group, 0];

            {
                _x params ["_type", "_name", "_description", "_position", "_formation", "_behaviour", "_combatMode", "_speedMode", "_timeout", "_completionRadius", "_statements", "_script"];

                private _waypoint = _group addWaypoint [_position vectorAdd _centerPos, -1];
                _waypoint setWaypointType _type;
                _waypoint setWaypointName _name;
                _waypoint setWaypointDescription _description;
                _waypoint setWaypointFormation _formation;
                _waypoint setWaypointBehaviour _behaviour;
                _waypoint setWaypointCombatMode _combatMode;
                _waypoint setWaypointSpeed _speedMode;
                _waypoint setWaypointTimeout _timeout;
                _waypoint setWaypointCompletionRadius _completionRadius;
                _waypoint setWaypointStatements _statements;
                _waypoint setWaypointScript _script;
            } forEach _waypoints;

            _group setCurrentWaypoint [_group, _currentWaypoint];
        }, [_centerPos, _group, _formation, _behaviour, _combatMode, _speedMode, _waypoints, _currentWaypoint]] call CBA_fnc_execNextFrame;

        _groups set [_index, _group];
    };

    _group
};

private _fnc_deserializeUnit = {
    params ["_type", "_position", "_direction", "_group", "_isLeader", "_rank", "_skill", "_stance", "_loadout", "_identity", "_flagTexture", "_attachedObjects"];

    _position = _position vectorAdd _centerPos;
    _group = _group call _fnc_deserializeGroup;

    private _unit = _group createUnit [_type, _position, [], 0, "CAN_COLLIDE"];
    _unit setVariable ["BIS_enableRandomization", false];

    _unit setDir _direction;
    _unit setRank _rank;
    _unit setSkill _skill;
    _unit setUnitPos _stance;
    _unit forceFlagTexture _flagTexture;

    // Ensure unit belongs to the same side as the group
    [_unit] joinSilent _group;

    if (_isLeader) then {
        _group selectLeader _unit;
        _group setFormDir _direction;
    };

    [{
        params ["_unit", "_loadout"];

        _unit setUnitLoadout _loadout;
        [_unit] call BIN_fnc_CBRNHoseInit;
    }, [_unit, _loadout]] call CBA_fnc_execNextFrame;

    if (!_enableRandomization) then {
        [{
            params ["_unit", "_identity"];
            _identity params ["_name", "_face", "_speaker", "_pitch", "_nameSound", "_insignia"];

            private _jipID = [QGVAR(setUnitIdentity), [_unit, _name, _face, _speaker, _pitch, _nameSound]] call CBA_fnc_globalEventJIP;
            [_jipID, _unit] call CBA_fnc_removeGlobalEventJIP;

            [_unit, _insignia] call BIS_fnc_setUnitInsignia;
        }, [_unit, _identity]] call CBA_fnc_execNextFrame;
    };

    [_unit, _attachedObjects] call _fnc_deserializeAttachedObjects;

    _objects pushBack _unit;

    _unit
};

private _fnc_deserializeVehicle = {
    params ["_type", "_position", "_direction", "_fuel", "_inventory", "_customization", "_flagTexture", "_turretMagazines", "_pylonMagazines", "_crew", "_vehicleCargo", "_slingLoadedObject", "_attachedObjects"];

    _position = _position vectorAdd _centerPos;

    private _placement = ["CAN_COLLIDE", "FLY"] select (_type isKindOf "Air" && {_position select 2 > 5});

    private _vehicle = createVehicle [_type, _position, [], 0, _placement];
    if (_direction isEqualType 0) then {
        _vehicle setDir _direction;
    } else {
        _vehicle setVectorDirAndUp _direction;
    };

    // FLY placement always places aircraft at the same height relative to the ground
    if (_placement == "FLY") then {
        _vehicle setPos _position;
    };

    _vehicle setFuel _fuel;
    _vehicle forceFlagTexture _flagTexture;

    [_vehicle, _inventory] call FUNC(deserializeInventory);

    if (_enableRandomization) then {
        [_vehicle, "", []] call BIS_fnc_initVehicle;
    } else {
        _customization params ["_textures", "_animations"];
        [_vehicle, _textures, _animations, true] call BIS_fnc_initVehicle;
    };

    {
        _x params ["_magazine", "_turretPath"];

        _vehicle removeMagazineTurret [_magazine, _turretPath];
    } forEach magazinesAllTurrets _vehicle;

    {
        _vehicle addMagazineTurret _x;
    } forEach _turretMagazines;

    {
        _x params ["_magazine", "_turretPath", "_ammoCount"];

        private _pylonIndex = _forEachIndex + 1;
        _vehicle setPylonLoadOut [_pylonIndex, _magazine, false, _turretPath];
        _vehicle setAmmoOnPylon [_pylonIndex, _ammoCount];
    } forEach _pylonMagazines;

    {
        _x params ["_unitData", "_role", "_cargoIndex", "_turretPath"];

        private _unit = _unitData call _fnc_deserializeUnit;

        switch (_role) do {
            case "driver": {
                if (getText (configOf _unit >> "simulation") == "UAVPilot") then {
                    _unit moveInAny _vehicle; // moveInDriver does not work for virtual UAV crew, moveInAny does
                } else {
                    _unit moveInDriver _vehicle;
                };
            };
            case "commander": {
                _unit moveInCommander _vehicle;
            };
            case "gunner": {
                _unit moveInGunner _vehicle;
            };
            case "turret": {
                _unit moveInTurret [_vehicle, _turretPath];
            };
            case "cargo": {
                _unit moveInCargo [_vehicle, _cargoIndex];
                _unit assignAsCargoIndex [_vehicle, _cargoIndex];
            };
        };
    } forEach _crew;

    {
        _vehicle setVehicleCargo (_x call _fnc_deserializeObject);
    } forEach _vehicleCargo;

    if (_slingLoadedObject isNotEqualTo []) then {
        _vehicle setSlingLoad (_slingLoadedObject call _fnc_deserializeObject);
    };

    [_vehicle, _attachedObjects] call _fnc_deserializeAttachedObjects;

    _objects pushBack _vehicle;

    _vehicle
};

private _fnc_deserializeStatic = {
    params ["_type", "_position", "_direction", "_simulationEnabled", "_inventory", "_attachedObjects"];

    _position = _position vectorAdd _centerPos;

    private _object = createVehicle [_type, [0, 0, 0], [], 0, "CAN_COLLIDE"];
    _object setPos _position;
    if (_direction isEqualType 0) then {
        _object setDir _direction;
    } else {
        _object setVectorDirAndUp _direction;
    };

    // Composition placement aligns objects to the surface normal if they are close to the ground
    // This also helps in preventing objects from being destroyed by cliping into the ground
    if (_position select 2 <= 0.2) then {
        _object setVectorUp surfaceNormal _position;
    };

    if (!_simulationEnabled) then {
        [QGVAR(enableSimulationGlobal), [_object, false]] call CBA_fnc_serverEvent;
    };

    [_object, _inventory] call FUNC(deserializeInventory);
    [_object, _attachedObjects] call _fnc_deserializeAttachedObjects;

    _objects pushBack _object;

    _object
};

private _fnc_deserializeAttachedObjects = {
    params ["_parentObject", "_attachedObjects"];

    {
        _x params ["_data", "_offset", "_dirAndUp"];

        private _object = _data call _fnc_deserializeObject;
        _object attachTo [_parentObject, _offset];
        _object setVectorDirAndUp _dirAndUp;
    } forEach _attachedObjects;
};

private _fnc_deserializeObject = {
    params ["_type"];

    if (_type isKindOf "AllVehicles") then {
        if (_type isKindOf "CAManBase") then {
            _this call _fnc_deserializeUnit
        } else {
            _this call _fnc_deserializeVehicle
        };
    } else {
        if (_type isKindOf "Thing" || {_type isKindOf "Static"}) then {
            _this call _fnc_deserializeStatic
        };
    };
};

{
    _x call _fnc_deserializeObject;
} forEach _objectData;

if (_makeEditable) then {
    [QGVAR(addObjects), [_objects]] call CBA_fnc_serverEvent;
};

_objects
