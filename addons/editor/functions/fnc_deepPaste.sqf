#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates objects based on the given deep copy data.
 *
 * Arguments:
 * 0: Units <ARRAY>
 * 1: Vehicles <ARRAY>
 * 2: Statics <ARRAY>
 * 3: Groups <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_units, _vehicles, _statics, _groups] call zen_editor_fnc_deepPaste
 *
 * Public: No
 */

params ["_units", "_vehicles", "_statics", "_groups"];

// Get the world position where the cursor is pointing
// Objects are created relative to the cursor
private _centerPos = ASLtoAGL ([nil, false] call EFUNC(common,getPosFromScreen));

// Keep track of all created objects to add them as editable objects at the end
private _createdObjects = [];
private _createdGroups  = [] call CBA_fnc_hashCreate;

private _fnc_createGroup = {
    params ["_index"];

    private _group = [_createdGroups, _index] call CBA_fnc_hashGet;

    if (isNil "_group") then {
        (_groups select _index) params ["_side", "_formation", "_behaviour", "_combatMode", "_speedMode", "_currentWaypoint", "_waypoints"];

        _group = createGroup [_side, true];
        _group setCombatMode _combatMode;
        _group setSpeedMode _speedMode;

        // For some reason, formation and behaviour need a frame delay to be correctly applied
        [{
            params ["_group", "_formation", "_behaviour"];

            _group setFormation _formation;
            _group setBehaviour _behaviour;
        }, [_group, _formation, _behaviour]] call CBA_fnc_execNextFrame;

        for "_i" from 1 to count waypoints _group do {
            deleteWaypoint [_group, 0];
        };

        {
            [_group, _x] call _fnc_createWaypoint;
        } forEach _waypoints;

        _group setCurrentWaypoint [_group, _currentWaypoint];

        [_createdGroups, _index, _group] call CBA_fnc_hashSet;
    };

    _group
};

private _fnc_createWaypoint = {
    params ["_group", "_waypointData"];
    _waypointData params ["_type", "_name", "_description", "_position", "_formation", "_behaviour", "_combatMode", "_speedMode", "_timeout", "_completionRadius", "_statements", "_script"];

    _position = _position vectorAdd _centerPos;

    private _waypoint = _group addWaypoint [_position, -1];
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

    // Waypoint 0 requires special handling
    // Otherwise it is created at the group's spawn position
    if (_waypoint select 1 == 0) then {
        [{
            params ["_waypoint", "_position"];

            _waypoint setWaypointPosition [AGLtoASL _position, -1];
        }, [_waypoint, _position]] call CBA_fnc_execNextFrame;
    };
};

private _fnc_createUnit = {
    params ["_type", "_position", "_direction", "_identity", "_rank", "_skill", "_stance", "_loadout", "_group", "_isLeader"];

    _position = _position vectorAdd _centerPos;
    _group = _group call _fnc_createGroup;

    private _unit = _group createUnit [_type, _position, [], 0, "NONE"];
    _unit setVariable ["BIS_enableRandomization", false];

    _unit setDir _direction;
    _unit setRank _rank;
    _unit setSkill _skill;
    _unit setUnitPos _stance;

    [{
        params ["_unit", "_identity", "_loadout"];
        _identity params ["_name", "_face", "_speaker", "_pitch", "_nameSound"];

        private _jipID = [QEGVAR(common,setUnitIdentity), [_unit, _name, _face, _speaker, _pitch, _nameSound]] call CBA_fnc_globalEventJIP;
        [_jipID, _unit] call CBA_fnc_removeGlobalEventJIP;

        _unit setUnitLoadout _loadout;
    }, [_unit, _identity, _loadout]] call CBA_fnc_execNextFrame;

    if (_isLeader) then {
        _group selectLeader _unit;
    };

    _createdObjects pushBack _unit;

    _unit
};

private _fnc_createVehicle = {
    params ["_type", "_position", "_dirAndUp", "_fuel", "_damage", "_hitPointsDamage", "_inventory", "_customization", "_turretMagazines", "_pylonMagazines", "_vehicleCargo", "_crew"];

    _position = _position vectorAdd _centerPos;

    private _placement = ["NONE", "FLY"] select (_type isKindOf "Air" && {_position select 2 > 5});
    private _vehicle = createVehicle [_type, _position, [], 0, _placement];
    _vehicle setVectorDirAndUp _dirAndUp;
    _vehicle setDamage _damage;
    _vehicle setFuel _fuel;

    {
        _vehicle setHitIndex [_forEachIndex, _x, false];
    } forEach _hitPointsDamage;

    [_vehicle, _inventory] call EFUNC(common,deserializeInventory);

    _customization params ["_textures", "_animations"];
    [_vehicle, _textures, _animations, true] call BIS_fnc_initVehicle;

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
        _vehicle setAmmoOnPylon  [_pylonIndex, _ammoCount];
    } forEach _pylonMagazines;

    {
        _vehicle setVehicleCargo (_x call _fnc_createVehicle);
    } forEach _vehicleCargo;

    {
        _x params ["_unitData", "_role", "_cargoIndex", "_turretPath"];

        private _unit = _unitData call _fnc_createUnit;

        switch (_role) do {
            case "driver": {
                if (getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") == "UAVPilot") then {
                    _unit moveInAny _vehicle; // moveInDriver does not appear to work for virtual UAV crew, moveInAny does
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

    _createdObjects pushBack _vehicle;

    _vehicle
};

private _fnc_createStatic = {
    params ["_type", "_position", "_dirAndUp", "_damage", "_inventory"];

    _position = _position vectorAdd _centerPos;

    private _object = createVehicle [_type, _position, [], 0, "NONE"];
    _object setVectorDirAndUp _dirAndUp;
    _object setDamage _damage;

    [_object, _inventory] call EFUNC(common,deserializeInventory);

    _createdObjects pushBack _object;

    _object
};

{
    _x call _fnc_createUnit;
} forEach _units;

{
    _x call _fnc_createVehicle;
} forEach _vehicles;

{
    _x call _fnc_createStatic;
} forEach _statics;

[QEGVAR(common,addObjects), [_createdObjects]] call CBA_fnc_serverEvent;
