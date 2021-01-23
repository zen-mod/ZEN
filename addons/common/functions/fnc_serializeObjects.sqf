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
 * Serialized Data <ARRAY>
 *
 * Example:
 * [_objects] call zen_common_fnc_serializeObjects
 *
 * Public: No
 */

params [["_objects", [], [[]]], ["_centerPos", nil, [[]], [2, 3]], ["_includeWaypoints", false, [false]]];

// Filter destroyed objects and any objects that are attached to or "part of" another
// The data for these objects will be included in the parent object's data
_objects = _objects select {alive _x && {vehicle _x == _x} && {isNull attachedTo _x} && {isNull ropeAttachedTo _x}};
_objects = _objects arrayIntersect _objects;

// Find the center position of all objects if one is not given
if (isNil "_centerPos") then {
    _centerPos = [0, 0, 0];

    {
        _centerPos = _centerPos vectorAdd getPos _x;
    } forEach _objects;

    _centerPos = _centerPos vectorMultiply (1 / (count _objects max 1));
};

// Set center position to ground level over land and water level over the ocean
_centerPos set [2, 0];

// Group data is serialized separately, object data will reference a group by its index in this array
private _groupData = [];
private _processedGroups = [];

private _fnc_serializeGroup = {
    params ["_unit"];

    private _group = group _unit;
    private _index = _processedGroups find _group;

    if (_index == -1) then {
        _index = _processedGroups pushBack _group;

        private _waypoints = [];

        if (_includeWaypoints) then {
            _waypoints = waypoints _group apply {
                [_x] call _fnc_serializeWaypoint
            };
        };

        _groupData pushBack [side _group, formation _group, behaviour leader _group, combatMode _group, speedMode _group, _waypoints, currentWaypoint _group];
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
    private _position = ASLtoAGL getPosASL _unit vectorDiff _centerPos;
    private _direction = getDir _unit;

    private _group = _unit call _fnc_serializeGroup;
    private _isLeader = leader _unit == _unit;

    private _rank = rank _unit;
    private _skill = skill _unit;
    private _stance = unitPos _unit;

    private _loadout = getUnitLoadout _unit;
    private _identity = [name _unit, face _unit, speaker _unit, pitch _unit, nameSound _unit, _unit call BIS_fnc_getUnitInsignia];
    private _flagTexture = getForcedFlagTexture _unit;

    private _attachedObjects = _unit call _fnc_serializeAttachedObjects;

    [_type, _position, _direction, _group, _isLeader, _rank, _skill, _stance, _loadout, _identity, _flagTexture, _attachedObjects]
};

private _fnc_serializeVehicle = {
    params ["_vehicle"];

    private _type = typeOf _vehicle;
    private _position = ASLtoAGL getPosASL _vehicle vectorDiff _centerPos;
    private _direction = [vectorDir _vehicle, vectorUp _vehicle];

    private _fuel = fuel _vehicle;
    private _inventory = _vehicle call FUNC(serializeInventory);
    private _customization = _vehicle call BIS_fnc_getVehicleCustomization;
    private _flagTexture = getForcedFlagTexture _vehicle;

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

    private _crew = [];

    {
        _x params ["_unit", "_role", "_cargoIndex", "_turretPath"];

        if (alive _unit) then {
            _crew pushBack [_unit call _fnc_serializeUnit, toLower _role, _cargoIndex, _turretPath];
        };
    } forEach fullCrew _vehicle;

    private _vehicleCargo = [];

    {
        if (alive _x) then {
            private _data = _x call _fnc_serializeObject;
            if (isNil "_data") exitWith {};

            _vehicleCargo pushBack _data;
        };
    } forEach getVehicleCargo _vehicle;

    private _slingLoadedObject = getSlingLoad _vehicle;

    if (alive _slingLoadedObject) then {
        _slingLoadedObject = _slingLoadedObject call _fnc_serializeObject;

        if (isNil "_slingLoadedObject") then {
            _slingLoadedObject = []; // Empty array to indicate that vehicle does not have a sling loaded object
        };
    };

    private _attachedObjects = _vehicle call _fnc_serializeAttachedObjects;

    [_type, _position, _direction, _fuel, _inventory, _customization, _flagTexture, _turretMagazines, _pylonMagazines, _crew, _vehicleCargo, _slingLoadedObject, _attachedObjects]
};

private _fnc_serializeStatic = {
    params ["_object"];

    private _type = typeOf _object;
    private _position = ASLtoAGL getPosASL _object vectorDiff _centerPos;
    private _direction = [vectorDir _object, vectorUp _object];

    private _simulationEnabled = simulationEnabled _object;
    private _inventory = _object call FUNC(serializeInventory);
    private _attachedObjects = _object call _fnc_serializeAttachedObjects;

    [_type, _position, _direction, _simulationEnabled, _inventory, _attachedObjects]
};

private _fnc_serializeAttachedObjects = {
    params ["_object"];

    private _attachedObjects = [];

    {
        // Filter vehicle cargo objects, they are also attached
        if (alive _x && {isNull isVehicleCargo _x}) then {
            private _data = _x call _fnc_serializeObject;
            if (isNil "_data") exitWith {};

            private _offset = _object worldToModel ASLtoAGL getPosASL _x;
            private _dirAndUp = [_object vectorWorldToModel vectorDir _x, _object vectorWorldToModel vectorUp _x];

            _attachedObjects pushBack [_data, _offset, _dirAndUp];
        };
    } forEach attachedObjects _object;

    _attachedObjects
};

private _fnc_serializeObject = {
    params ["_object"];

    if (_object isKindOf "AllVehicles") then {
        if (_object isKindOf "CAManBase") then {
            _object call _fnc_serializeUnit
        } else {
            if (_object isKindOf "Animal") exitWith {};
            _object call _fnc_serializeVehicle
        };
    } else {
        if (_object isKindOf "Static" || {_object isKindOf "Thing"}) then {
            if (_object isKindOf "ThingEffect") exitWith {};
            _object call _fnc_serializeStatic
        };
    };
};

private _objectData = [];

{
    private _data = _x call _fnc_serializeObject;

    if (!isNil "_data") then {
        _objectData pushBack _data;
    };
} forEach _objects;

[_objectData, _groupData]
