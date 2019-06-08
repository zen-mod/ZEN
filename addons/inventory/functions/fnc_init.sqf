/*
 * Author: mharis001
 * Initializes the "Inventory" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_init
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display"];

private _object  = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _cargo   = _object call EFUNC(common,getInventory);
private _maxLoad = getNumber (configFile >> "CfgVehicles" >> typeOf _object >> "maximumLoad");

_display setVariable [QGVAR(cargo), _cargo];
_display setVariable [QGVAR(maxLoad), _maxLoad];

// Calculate the current load
[_display] call FUNC(calculateLoad);

// Refresh list when category is changed
private _ctrlCategory = _display displayCtrl IDC_CATEGORY;
_ctrlCategory ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlCategory"];

    private _display = ctrlParent _ctrlCategory;
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

// Add or remove items using the list buttons
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

// Add or remove items using keyboard
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

// Clear cargo from current category
private _ctrlButtonClear = _display displayCtrl IDC_BTN_CLEAR;
_ctrlButtonClear ctrlAddEventHandler ["ButtonClick", {call FUNC(clear)}];

// Confirm changes to inventory
private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {call FUNC(confirm)}];

// Update the load bar for current load
[_display] call FUNC(updateLoadBar);

// Populate the list with items
[_display] call FUNC(fillList);
