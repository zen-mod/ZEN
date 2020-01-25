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

private _config = configFile >> "CfgVehicles" >> typeOf _object;
private _displayName = getText (_config >> "displayName");
private _maximumLoad = getNumber (_config >> "maximumLoad");

// Get the object's current inventory and calculate its load
private _cargo = [getItemCargo _object, getWeaponCargo _object, getMagazineCargo _object, getBackpackCargo _object];
private _currentLoad = [_cargo] call FUNC(calculateLoad);

private _display = uiNamespace getVariable QGVAR(display);
_display setVariable [QGVAR(currentLoad), _currentLoad];
_display setVariable [QGVAR(maximumLoad), _maximumLoad];
_display setVariable [QGVAR(object), _object];
_display setVariable [QGVAR(cargo), _cargo];

// Set the display's title to the object name
private _ctrlTitle = _display displayCtrl IDC_TITLE;
_ctrlTitle ctrlSetText toUpper format [localize LSTRING(EditInventory), _displayName];

// Adjust display element positions based on the content height
[_display] call EFUNC(common,initDisplayPositioning);

// Refresh the items list when category is changed
private _ctrlCategory = _display displayCtrl IDC_CATEGORY;
_ctrlCategory ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlCategory"];

    private _display = ctrlParent _ctrlCategory;
    [_display] call FUNC(refreshList);
}];

// Refresh the items list when the search field changes
private _ctrlSearchBar = _display displayCtrl IDC_SEARCH_BAR;
_ctrlSearchBar ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlSearchBar"];

    private _display = ctrlParent _ctrlSearchBar;
    [_display] call FUNC(refreshList);
}];

// Clear search when the search bar is right clicked
_ctrlSearchBar ctrlAddEventHandler ["MouseButtonClick", {
    params ["_ctrlSearchBar", "_button"];

    if (_button != 1) exitWith {};

    _ctrlSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlSearchBar;

    private _display = ctrlParent _ctrlSearchBar;
    [_display] call FUNC(refreshList);
}];

// Clear search when the search button is clicked
private _ctrlButtonSearch = _display displayCtrl IDC_BTN_SEARCH;
_ctrlButtonSearch ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonSearch"];

    private _display = ctrlParent _ctrlButtonSearch;
    private _ctrlSearchBar = _display displayCtrl IDC_SEARCH_BAR;
    _ctrlSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlSearchBar;

    [_display] call FUNC(refreshList);
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
    [_display] call FUNC(updateButtons);
}];

// Clear items from the current category when the clear button is clicked
private _ctrlButtonClear = _display displayCtrl IDC_BTN_CLEAR;
_ctrlButtonClear ctrlAddEventHandler ["ButtonClick", {call FUNC(clear)}];

// Confirm changes to the inventory when the OK button is clicked
private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {call FUNC(confirm)}];

// Update the load bar for the current load
[_display] call FUNC(updateLoadBar);

// Initially populate the list with items
[_display] call FUNC(refreshList);
