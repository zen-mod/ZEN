#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens a dialog to configure the inventory of the given object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call zen_inventory_fnc_configure
 *
 * Public: No
 */

params ["_object"];

if (!createDialog QGVAR(display)) exitWith {};

private _config = configOf _object;
private _displayName = getText (_config >> "displayName");
private _maximumLoad = getNumber (_config >> "maximumLoad");

// Get the object's current cargo and calculate its load
private _cargo = [getItemCargo _object, getWeaponCargo _object, getMagazineCargo _object, getBackpackCargo _object];
private _currentLoad = [_cargo] call FUNC(calculateLoad);

private _display = uiNamespace getVariable QEGVAR(common,display);
_display setVariable [QGVAR(currentLoad), _currentLoad];
_display setVariable [QGVAR(maximumLoad), _maximumLoad];
_display setVariable [QGVAR(object), _object];
_display setVariable [QGVAR(cargo), _cargo];

// Adjust display element positions based on the content height
[_display] call EFUNC(common,initDisplayPositioning);

// Set the display's title to the object name
private _ctrlTitle = _display displayCtrl IDC_TITLE;
_ctrlTitle ctrlSetText toUpper format [localize LSTRING(EditInventory), _displayName];

// Refresh the items list when category is changed
private _ctrlCategory = _display displayCtrl IDC_CATEGORY;
_ctrlCategory ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlCategory"];

    private _display = ctrlParent _ctrlCategory;
    [_display] call FUNC(refresh);
}];

// Refresh the items list when the search field changes
private _ctrlSearchBar = _display displayCtrl IDC_SEARCH_BAR;
_ctrlSearchBar ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlSearchBar"];

    private _display = ctrlParent _ctrlSearchBar;
    [_display] call FUNC(refresh);
}];

// Clear search when the search bar is right clicked
_ctrlSearchBar ctrlAddEventHandler ["MouseButtonClick", {
    params ["_ctrlSearchBar", "_button"];

    if (_button != 1) exitWith {};

    _ctrlSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlSearchBar;

    private _display = ctrlParent _ctrlSearchBar;
    [_display] call FUNC(refresh);
}];

// Clear search when the search button is clicked
private _ctrlButtonSearch = _display displayCtrl IDC_BTN_SEARCH;
_ctrlButtonSearch ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonSearch"];

    private _display = ctrlParent _ctrlButtonSearch;
    private _ctrlSearchBar = _display displayCtrl IDC_SEARCH_BAR;
    _ctrlSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlSearchBar;

    [_display] call FUNC(refresh);
}];

// Handle adding/removing items using the list buttons
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

// Handle adding/removing items using keyboard
private _ctrlList = _display displayCtrl IDC_LIST;
_ctrlList ctrlAddEventHandler ["SetFocus", {
    params ["_ctrlList"];

    private _display = ctrlParent _ctrlList;
    _display setVariable [QGVAR(listFocused), true];
}];

_ctrlList ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlList"];

    private _display = ctrlParent _ctrlList;
    _display setVariable [QGVAR(listFocused), false];
}];

_display displayAddEventHandler ["KeyDown", {call FUNC(keyDown)}];

// Update add/remove buttons when list selection changes
_ctrlList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlList"];

    private _display = ctrlParent _ctrlList;
    [_display, true] call FUNC(update);
}];

// Refresh the items list when the weapon specific category is changed
private _ctrlWeaponCategory = _display displayCtrl IDC_WEAPON_CATEGORY;
_ctrlWeaponCategory ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlWeaponCategory"];

    private _display = ctrlParent _ctrlWeaponCategory;
    [_display] call FUNC(refresh);
}];

// Exit weapon specific mode when the weapon group's close button is clicked
private _ctrlWeaponClose = _display displayCtrl IDC_WEAPON_CLOSE;
_ctrlWeaponClose ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlWeaponClose"];

    private _display = ctrlParent _ctrlWeaponClose;
    [_display, false] call FUNC(switchMode);
}];

// Switch to weapon specific mode when a the weapon specific items button is clicked or a list item is double clicked
private _ctrlButtonWeapon = _display displayCtrl IDC_BTN_WEAPON;
_ctrlButtonWeapon ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonWeapon"];

    private _display = ctrlParent _ctrlButtonWeapon;
    [_display, true] call FUNC(switchMode);
}];

_ctrlList ctrlAddEventHandler ["LBDblClick", {
    params ["_ctrlList"];

    private _display = ctrlParent _ctrlList;
    [_display, true] call FUNC(switchMode)
}];

// Reset to the default inventory when the reset button is clicked
private _ctrlButtonReset = _display displayCtrl IDC_BTN_RESET;
_ctrlButtonReset ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonReset"];

    private _display = ctrlParent _ctrlButtonReset;
    [_display] call FUNC(reset);
}];

// Clear items from the current category when the clear button is clicked
private _ctrlButtonClear = _display displayCtrl IDC_BTN_CLEAR;
_ctrlButtonClear ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonClear"];

    private _display = ctrlParent _ctrlButtonClear;
    [_display] call FUNC(clear);
}];

// Confirm changes to the inventory when the OK button is clicked
private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {call FUNC(confirm)}];

// Initialize the list sorting modes
private _ctrlSorting = _display displayCtrl IDC_SORTING;
[_ctrlSorting, _ctrlList, [1, 2]] call EFUNC(common,initListNBoxSorting);

// Initially populate the list with items
[_display] call FUNC(refresh);
