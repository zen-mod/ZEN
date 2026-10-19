#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given item is a container item (uniform, vest, or backpack).
 *
 * Arguments:
 * 0: Item <STRING|OBJECT>
 *
 * Return Value:
 * Is Container Item <BOOL>
 *
 * Example:
 * ["B_AssaultPack_blk"] call zen_common_fnc_isContainerItem
 *
 * Public: No
 */

params [["_item", "", ["", objNull]]];

if (_item isEqualType objNull) then {
    _item = typeOf _item;
};

// Inventory item with container storage (uniform or vest)
getText (configFile >> "CfgWeapons" >> _item >> "ItemInfo" >> "containerClass") != ""
// Backpack
|| {getNumber (configFile >> "CfgVehicles" >> _item >> "isBackpack") == 1}
