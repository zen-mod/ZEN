#include "script_component.hpp"
/*
 * Author: mharis001
 * Switches the mode of the inventory display between all items and weapon specific items.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Weapon Specific Mode <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, true] call zen_inventory_fnc_switchMode
 *
 * Public: No
 */

params ["_display", "_weaponMode"];

scopeName "Main";

if (_weaponMode) then {
    // Exit if the currently selected item is not a weapon
    private _ctrlList = _display displayCtrl IDC_LIST;
    private _weapon = _ctrlList lnbData [lnbCurSelRow _ctrlList, 0];

    if !(_weapon call EFUNC(common,isWeapon)) then {
        breakOut "Main";
    };

    // Update the weapon specific group's title and picture to reflect the selected weapon
    private _config = configFile >> "CfgWeapons" >> _weapon;
    private _name = getText (_config >> "displayName");
    private _picture = getText (_config >> "picture");

    private _ctrlWeaponTitle = _display displayCtrl IDC_WEAPON_TITLE;
    _ctrlWeaponTitle ctrlSetText _name;

    private _ctrlWeaponPicture = _display displayCtrl IDC_WEAPON_PICTURE;
    _ctrlWeaponPicture ctrlSetTooltip format ["%1\n%2", _name, _weapon];
    _ctrlWeaponPicture ctrlSetText _picture;

    _display setVariable [QGVAR(weapon), _weapon];
} else {
    // Exit if the display is already not in weapon specific mode
    if (_display getVariable [QGVAR(weapon), ""] == "") then {
        breakOut "Main";
    };

    _display setVariable [QGVAR(weapon), ""];
};

// Clear search when switching modes for QOL
private _ctrlSearchBar = _display displayCtrl IDC_SEARCH_BAR;
_ctrlSearchBar ctrlSetText "";

// Switch between showing the all items categories and weapon specific group
private _ctrlCategory = _display displayCtrl IDC_CATEGORY;
_ctrlCategory ctrlShow !_weaponMode;

private _ctrlWeaponGroup = _display displayCtrl IDC_WEAPON_GROUP;
_ctrlWeaponGroup ctrlShow _weaponMode;

// Refresh the list after switching modes
_display call FUNC(refresh);
