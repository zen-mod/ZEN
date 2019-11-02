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
    case (_item in (_itemsList select 0));
    case (_item in (_itemsList select 1));
    case (_item in (_itemsList select 2));
    case (_item in (_itemsList select 14)): {
        configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo";
    };
    case (_item in (_itemsList select 7));
    case (_item in (_itemsList select 20));
    case (_item in (_itemsList select 21)): {
        configFile >> "CfgMagazines" >> _item;
    };
    case (_item in (_itemsList select 11)): {
        configFile >> "CfgVehicles" >> _item;
    };
    case (_item in (_itemsList select 12)): {
        configFile >> "CfgGlasses" >> _item;
    };
    default {
        configFile >> "CfgWeapons" >> _item >> "ItemInfo";
    };
};

getNumber (_config >> "mass")
