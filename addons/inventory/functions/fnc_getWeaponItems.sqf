#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns items compatible with the selected weapon in the inventory display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * Compatible Items <ARRAY>
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_getWeaponItems
 *
 * Public: No
 */

params ["_display"];

private _weapon = _display getVariable [QGVAR(weapon), ""];
private _category = lbCurSel (_display displayCtrl IDC_WEAPON_CATEGORY);

if (_category == 4) then {
    [_weapon, true] call CBA_fnc_compatibleMagazines
} else {
    private _cfgWeapons = configFile >> "CfgWeapons";
    private _type = ["optic", "pointer", "muzzle", "bipod"] select _category;

    [_weapon, _type] call CBA_fnc_compatibleItems select {
        getNumber (_cfgWeapons >> _x >> "scope") == 2
    }
};
