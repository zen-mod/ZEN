/*
 * Author: mharis001
 * Returns the current inventory of an object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * Inventory <ARRAY>
 *
 * Example:
 * [cursorObject] call zen_common_fnc_getInventory
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_object"];

[getItemCargo _object, getWeaponCargo _object, getMagazineCargo _object, getBackpackCargo _object]
