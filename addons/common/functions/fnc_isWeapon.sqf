#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given inventory item is a primary, secondary, or handgun weapon.
 *
 * Arguments:
 * 0: Item <STRING>
 *
 * Return Value:
 * Is Weapon <BOOL>
 *
 * Example:
 * ["arifle_MX_F"] call zen_common_fnc_isWeapon
 *
 * Public: No
 */

params [["_item", "", [""]]];

getNumber (configFile >> "CfgWeapons" >> _item >> "type") in [TYPE_WEAPON_PRIMARY, TYPE_WEAPON_SECONDARY, TYPE_WEAPON_HANDGUN]
