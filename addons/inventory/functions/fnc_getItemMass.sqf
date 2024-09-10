#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the mass of the given item.
 *
 * Arguments:
 * 0: Item <STRING>
 *
 * Return Value:
 * Mass <NUMBER>
 *
 * Example:
 * ["FirstAidKit"] call zen_inventory_fnc_getItemMass
 *
 * Public: No
 */

params ["_item"];

private _itemsList = uiNamespace getVariable QGVAR(itemsList);

private _config = switch (true) do {
    case (_item in (_itemsList select ITEMS_PRIMARY));
    case (_item in (_itemsList select ITEMS_SECONDARY));
    case (_item in (_itemsList select ITEMS_HANDGUN));
    case (_item in (_itemsList select ITEMS_BINOCULARS)): {
        configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo";
    };
    case (_item in (_itemsList select ITEMS_MAGAZINES));
    case (_item in (_itemsList select ITEMS_THROW));
    case (_item in (_itemsList select ITEMS_PUT)): {
        configFile >> "CfgMagazines" >> _item;
    };
    case (_item in (_itemsList select ITEMS_BACKPACKS)): {
        configFile >> "CfgVehicles" >> _item;
    };
    case (_item in (_itemsList select ITEMS_GOGGLES)): {
        configFile >> "CfgGlasses" >> _item;
    };
    default {
        configFile >> "CfgWeapons" >> _item >> "ItemInfo";
    };
};

getNumber (_config >> "mass")
