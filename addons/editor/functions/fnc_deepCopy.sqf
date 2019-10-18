#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns deep copy data for the given objects.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 *
 * Return Value:
 * Object Data <ARRAY>
 *
 * Example:
 * [_objects] call zen_editor_fnc_deepCopy
 *
 * Public: No
 */

params ["_objects"];

// Filter destroyed objects and get the vehicle for mounted infantry
_objects = _objects select {alive _x && {isNull isVehicleCargo _x}} apply {vehicle _x};
_objects = _objects arrayIntersect _objects;

// Get the world position where the cursor is pointing
// Object positions are copied relative to the cursor
private _centerPos = if (visibleMap) then {
    private _ctrlMap = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
    _pos2D + [0]
} else {
    screenToWorld getMousePosition
};

private _units = [];
private _vehicles = [];
private _statics = [];

private _groups = [];
private _indexedGroups = [];

private _fnc_serializeGroup = {
    params ["_unit"];

    private _group = group _unit;
    private _index = _indexedGroups find _group;

    if (_index == -1) then {
        _index = _indexedGroups pushBack _group;

        _groups pushBack [side _group, formation _group, behaviour leader _group, combatMode _group, speedMode _group];
    };

    _index
};

private _fnc_serializeInventory = {
    params ["_object"];

    // Handle containers inside the object's inventory
    private _containers = everyContainer _object apply {
        _x params ["_type", "_object"];

        [_type, _object call _fnc_serializeInventory]
    };

    [getItemCargo _object, weaponsItemsCargo _object, getMagazineCargo _object, getBackpackCargo _object, _containers]
};

private _fnc_serializeUnit = {
    params ["_unit"];

    private _type = typeOf _unit;
    private _position = getPosATL _unit vectorDiff _centerPos;
    private _direction = getDir _unit;

    private _rank = rank _unit;
    private _skill = skill _unit;
    private _stance = unitPos _unit;
    private _loadout = getUnitLoadout _unit;

    private _group = _unit call _fnc_serializeGroup;
    private _isLeader = leader _unit == _unit;

    [_type, _position, _direction, _rank, _skill, _stance, _loadout, _group, _isLeader]
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

    private _inventory = _vehicle call _fnc_serializeInventory;
    private _customization = _vehicle call BIS_fnc_getVehicleCustomization;

    private _turretMagazines = magazinesAllTurrets _vehicle apply {
        _x select [0, 3] // Discard ID and creator
    };

    private _vehicleCargo = getVehicleCargo _vehicle apply {
        _x call _fnc_serializeVehicle;
    };

    // todo: pylons
    private _pylonMagazines = [];

    private _crew = fullCrew _vehicle apply {
        _x params ["_unit", "_role", "_cargoIndex", "_turretPath"];

        [_unit call _fnc_serializeUnit, toLower _role, _cargoIndex, _turretPath]
    };

    [_type, _position, _dirAndUp, _inventory, _customization, _turretMagazines, _pylonMagazines, _vehicleCargo, _crew]
};

private _fnc_serializeStatic = {
    params ["_object"];

    private _type = typeOf _x;
    private _position = getPosATL _object vectorDiff _centerPos;
    private _dirAndUp = [vectorDir _object, vectorUp _object];

    private _damage = damage _object;
    private _inventory = _object call _fnc_serializeInventory;

    [_type, _position, _dirAndUp, _damage, _inventory]
};

{
    switch (true) do {
        case (_x isKindOf "CAManBase"): {
            _units pushBack (_x call _fnc_serializeUnit);
        };
        case (_x isKindOf "AllVehicles"): {
            _vehicles pushBack (_x call _fnc_serializeVehicle);
        };
        case (_x isKindOf "Thing");
        case (_x isKindOf "Static"): {
            _statics pushBack (_x call _fnc_serializeStatic);
        };
    };
} forEach _objects;

[_units, _vehicles, _statics, _groups]
