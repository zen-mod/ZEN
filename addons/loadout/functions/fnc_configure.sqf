#include "script_component.hpp"
/*
 * Author: NeilZar
 * Opens a dialog to configure the magazine loadout of the given vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call zen_loadout_fnc_configure
 *
 * Public: No
 */

params ["_vehicle"];

if (!createDialog QGVAR(display)) exitWith {};

private _weaponList = _vehicle call FUNC(getWeaponList);
private _displayName = getText (configOf _vehicle >> "displayName");

private _display = uiNamespace getVariable QEGVAR(common,display);
_display setVariable [QGVAR(weaponList), _weaponList];
_display setVariable [QGVAR(changes), []];
_display setVariable [QGVAR(vehicle), _vehicle];

[_display] call EFUNC(common,initDisplayPositioning);

// Set the display's title to the object name
private _ctrlTitle = _display displayCtrl IDC_TITLE;
_ctrlTitle ctrlSetText toUpper format [localize LSTRING(EditLoadout), _displayName];

// Add the vehicle's weapons to the combo box
private _ctrlWeapon = _display displayCtrl IDC_WEAPON;

{
    _x params ["_weapon", "_turretPath"];

    private _weaponName = [_vehicle, _weapon, _turretPath] call FUNC(getWeaponName);
    _ctrlWeapon lbAdd _weaponName;
} forEach _weaponList;

_ctrlWeapon lbSetCurSel 0;

// Refresh list when weapon is changed
_ctrlWeapon ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlWeapon"];

    private _display = ctrlParent _ctrlWeapon;
    [_display] call FUNC(fillList);
}];

// Refresh list with filter on search
private _ctrlSearchBar = _display displayCtrl IDC_SEARCH_BAR;
_ctrlSearchBar ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlSearchBar"];

    private _display = ctrlParent _ctrlSearchBar;
    [_display] call FUNC(fillList);
}];

// Clear search when search bar is right clicked
_ctrlSearchBar ctrlAddEventHandler ["MouseButtonClick", {
    params ["_ctrlSearchBar", "_button"];

    if (_button != 1) exitWith {};

    _ctrlSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlSearchBar;

    private _display = ctrlParent _ctrlSearchBar;
    [_display] call FUNC(fillList);
}];

// Clear search when search button is clicked
private _ctrlButtonSearch = _display displayCtrl IDC_BTN_SEARCH;
_ctrlButtonSearch ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonSearch"];

    private _display = ctrlParent _ctrlButtonSearch;
    private _ctrlSearchBar = _display displayCtrl IDC_SEARCH_BAR;
    _ctrlSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlSearchBar;

    [_display] call FUNC(fillList);
}];

// Add or remove magazines using the list buttons
private _ctrlButtonAdd = _display displayCtrl IDC_BTN_ADD;
_ctrlButtonAdd ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonAdd"];

    private _display = ctrlParent _ctrlButtonAdd;
    [_display, true] call FUNC(modify);
}];

private _ctrlButtonRemove = _display displayCtrl IDC_BTN_REMOVE;
_ctrlButtonRemove ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonRemove"];

    private _display = ctrlParent _ctrlButtonRemove;
    [_display, false] call FUNC(modify);
}];

// Add or remove magazines using keyboard
private _ctrlList = _display displayCtrl IDC_LIST;
_ctrlList ctrlAddEventHandler ["SetFocus", {
    params ["_ctrlList"];

    private _display = ctrlParent _ctrlList;
    _display setVariable [QGVAR(listFocus), true];
}];

_ctrlList ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlList"];

    private _display = ctrlParent _ctrlList;
    _display setVariable [QGVAR(listFocus), false];
}];

_display displayAddEventHandler ["KeyDown", {call FUNC(keyDown)}];

// Update add or remove buttons when list selection changes
_ctrlList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlList"];

    private _display = ctrlParent _ctrlList;
    [_display] call FUNC(updateButtons);
}];

// Clear magazines from current weapon
private _ctrlButtonClear = _display displayCtrl IDC_BTN_CLEAR;
_ctrlButtonClear ctrlAddEventHandler ["ButtonClick", {call FUNC(clear)}];

// Confirm changes to inventory
private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {call FUNC(confirm)}];

// Populate the list with magazines
[_display] call FUNC(fillList);
