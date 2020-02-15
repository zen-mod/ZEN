#include "script_component.hpp"
/*
 * Author: mharis001
 * Calculates the total mass of all items in the given inventory.
 *
 * Arguments:
 * 0: Inventory <ARRAY>
 *
 * Return Value:
 * Load <NUMBER>
 *
 * Example:
 * [_inventory] call zen_inventory_fnc_calculateLoad
 *
 * Public: No
 */

params ["_inventory"];
_inventory params ["_itemCargo", "_weaponCargo", "_magazineCargo", "_backpackCargo"];

private _load = 0;
private _cfgGlasses   = configFile >> "CfgGlasses";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgVehicles  = configFile >> "CfgVehicles";
private _cfgWeapons   = configFile >> "CfgWeapons";

// Add the masses of "regular" items in the inventory
// Handle separating CfgGlasses items from the items cargo
_itemCargo params ["_itemTypes", "_itemCounts"];

{
    private _config = if (isClass (_cfgGlasses >> _x)) then {
        _cfgGlasses >> _x
    } else {
        _cfgWeapons >> _x >> "ItemInfo"
    };

    _load = _load + getNumber (_config >> "mass") * (_itemCounts select _forEachIndex);
} forEach _itemTypes;

// Add the masses of weapons in the inventory
_weaponCargo params ["_weaponTypes", "_weaponCounts"];

{
    _load = _load + getNumber (_cfgWeapons >> _x >> "WeaponSlotsInfo" >> "mass") * (_weaponCounts select _forEachIndex);
} forEach _weaponTypes;

// Add the masses of magazines in the inventory
_magazineCargo params ["_magazineTypes", "_magazineCounts"];

{
    _load = _load + getNumber (_cfgMagazines >> _x >> "mass") * (_magazineCounts select _forEachIndex);
} forEach _magazineTypes;

// Add the masses of backpacks in the inventory
_backpackCargo params ["_backpackTypes", "_backpackCounts"];

{
    _load = _load + getNumber (_cfgVehicles >> _x >> "mass") * (_backpackCounts select _forEachIndex);
} forEach _backpackTypes;

_load
