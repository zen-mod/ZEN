/*
 * Author: mharis001
 * Sets the given inventory data as the inventory of an object.
 * Inventory array must be in format returned by the getInventory function.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Inventory <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, inventoryData] call zen_common_fnc_setInventory
 *
 * Public: No
 */
#include "script_component.hpp"

#define ADD_CARGO(object,command,cargo) \
    cargo params ["_items", "_counts"]; \
    { \
        object command [_x, _counts select _forEachIndex]; \
    } forEach _items

params ["_object", "_inventory"];
_inventory params ["_itemCargo", "_weaponCargo", "_magazineCargo", "_backpackCargo"];

clearItemCargoGlobal _object;
clearWeaponCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearBackpackCargoGlobal _object;

ADD_CARGO(_object,addItemCargoGlobal,_itemCargo);
ADD_CARGO(_object,addWeaponCargoGlobal,_weaponCargo);
ADD_CARGO(_object,addMagazineCargoGlobal,_magazineCargo);
ADD_CARGO(_object,addBackpackCargoGlobal,_backpackCargo);
