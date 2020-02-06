#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns serialized object data for the given objects.
 * Position offset for the objects is calculated relative to the center position.
 * If a center position is not given, the centroid of the objects is used.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: Center Position <ARRAY> (default: nil)
 * 2: Include Waypoints <BOOL> (default: false)
 *
 * Return Value:
 * Object Data <ARRAY>
 *
 * Example:
 * [_objects] call zen_common_fnc_serializeObjects
 *
 * Public: No
 */

params [["_objects", [], [[]]], ["_centerPos", nil, [[]]], ["_includeWaypoints", false, [false]]];

// Filter destroyed objects and any objects that are attached to or "part of" another
_objects = _objects select {alive _x && {vehicle _x == _x} && {isNull attachedTo _x} && {isNull isVehicleCargo _x} && {isNull ropeAttachedTo _x}};
_objects = _objects arrayIntersect _objects;

// Exit if no valid objects to serialize are given
if (_objects isEqualTo []) exitWith {[]};

// Find the center position of all objects if one is not given
if (isNil "_centerPos") then {
    _centerPos = [0, 0, 0];

    {
        _centerPos = _centerPos vectorAdd getPosATL _x;
    } forEach _objects;

    _centerPos = _centerPos vectorMultiply (1 / count _objects);
    _centerPos set [2, 0];
};

// Serialize group data in a separate array
// Object data will reference a group by its index in this array
private _groups = [];
private _indexedGroups = [];

private _fnc_serializeGroup = {
    params ["_unit"];

    private _group = group _unit;
    private _index = _indexedGroups find _group;

    if (_index == -1) then {
        _index = _indexedGroups pushBack _group;

        private _waypoints = [];

        if (_includeWaypoints) then {
            _waypoints = waypoints _group apply {
                [_x] call _fnc_serializeWaypoint
            };
        };

        _groups pushBack [side _group, formation _group, behaviour leader _group, combatMode _group, speedMode _group, _waypoints, currentWaypoint _group];
    };

    _index
};

private _fnc_serializeWaypoint = {
    params ["_waypoint"];

    [
        waypointType _waypoint,
        waypointName _waypoint,
        waypointDescription _waypoint,
        waypointPosition _waypoint vectorDiff _centerPos,
        waypointFormation _waypoint,
        waypointBehaviour _waypoint,
        waypointCombatMode _waypoint,
        waypointSpeed _waypoint,
        waypointTimeout _waypoint,
        waypointCompletionRadius _waypoint,
        waypointStatements _waypoint,
        waypointScript _waypoint
    ]
};

private _fnc_serializeUnit = {
    params ["_unit"];

    private _type = typeOf _unit;
    private _position = getPosATL _unit vectorDiff _centerPos;
    private _direction = getDir _unit;

    private _group = _unit call _fnc_serializeGroup;
    private _isLeader = leader _unit == _unit;

    private _rank = rank _unit;
    private _skill = skill _unit;
    private _stance = stance _unit;

    private _loadout = getUnitLoadout _unit;
    private _identity = [name _unit, face _unit, speaker _unit, pitch _unit, nameSound _unit];
    private _flagTexture = getForcedFlagTexture _unit;

    private _attachedObjects = _unit call _fnc_serializeAttachedObjects;

    [_type, _position, _direction, _group, _isLeader, _rank, _skill, _stance, _loadout, _identity, _flagTexture, _attachedObjects]
};

private _fnc_serializeVehicle = {
    params ["_vehicle"];

    private _type = typeOf _vehicle;
    private _dirAndUp = [vectorDir _vehicle, vectorUp _vehicle];
    private _simulation = getText (configFile >> "CfgVehicles" >> _type >> "simulation");

    // Use position AGL if vehicle is boat or amphibious
    private _position = if (_simulation == "ship" || {_simulation == "shipx"}) then {
        ASLtoAGL getPosASL _vehicle
    } else {
        getPosATL _vehicle
    };

    _position = _position vectorDiff _centerPos;

    private _fuel = fuel _vehicle;
    private _damage = damage _vehicle;
    private _hitPointsDamage = getAllHitPointsDamage _vehicle select 2;

    private _inventory = _vehicle call FUNC(serializeInventory);
    private _customization = _vehicle call BIS_fnc_getVehicleCustomization;

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

    private _crew = fullCrew _vehicle apply {
        _x params ["_unit", "_role", "_cargoIndex", "_turretPath"];

        [_unit call _fnc_serializeUnit, toLower _role, _cargoIndex, _turretPath]
    };

    private _vehicleCargo = getVehicleCargo _vehicle apply {
        _x call _fnc_serializeObject
    };

    private _slingloadCargo = if (isNull getSlingLoad _vehicle) then {
        [] // Empty array to indicate that vehicle does not have slingloaded cargo
    } else {
        getSlingLoad _vehicle call _fnc_serializeObject
    };

    private _attachedObjects = _vehicle call _fnc_serializeAttachedObjects;

    [_type, _position, _dirAndUp, _fuel, _damage, _hitPointsDamage, _inventory, _customization, _turretMagazines, _pylonMagazines, _crew, _vehicleCargo, _slingloadCargo, _attachedObjects]
};

private _fnc_serializeStatic = {
    params ["_object"];

    private _type = typeOf _object;
    private _position = getPosATL _object vectorDiff _centerPos;
    private _dirAndUp = [vectorDir _object, vectorUp _object];

    private _damage = damage _object;
    private _inventory = _object call FUNC(serializeInventory);
    private _attachedObjects = _object call _fnc_serializeAttachedObjects;

    [_type, _position, _dirAndUp, _damage, _inventory, _attachedObjects]
};

private _fnc_serializeAttachedObjects = {
    params ["_object"];

    attachedObjects _object select {
        isNull isVehicleCargo _x // Filter vehicle cargo objects, they are also attached
    } apply {
        [_x call _fnc_serializeObject, _object worldToModel ASLtoAGL getPosASL _x, [vectorDir _x, vectorUp _x]]
    }
};

private _fnc_serializeObject = {
    params ["_object"];

    if (_object isKindOf "AllVehicles") then {
        if (_object isKindOf "CAManBase") then {
            _object call _fnc_serializeUnit
        } else {
            _object call _fnc_serializeVehicle
        };
    } else {
        if (_object isKindOf "Thing" || {_object isKindOf "Static"}) then {
            _object call _fnc_serializeStatic
        };
    };
};

[_objects apply {_x call _fnc_serializeObject}, _groups]
