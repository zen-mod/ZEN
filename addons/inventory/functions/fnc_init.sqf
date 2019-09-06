#include "script_component.hpp"
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

params ["_controlsGroup", "_entity", "_defaultValue"];

private _maxLoad = getNumber (configFile >> "CfgVehicles" >> typeOf _entity >> "maximumLoad");

_controlsGroup setVariable [QEGVAR(attributes,value), _defaultValue];
_controlsGroup setVariable [QGVAR(maxLoad), _maxLoad];

// Calculate the current load
[_controlsGroup] call FUNC(calculateLoad);

// Refresh list when category is changed
private _ctrlCategory = _controlsGroup controlsGroupCtrl IDC_CATEGORY;
_ctrlCategory ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlCategory"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlCategory;
    [_controlsGroup] call FUNC(fillList);
}];

// Refresh list with filter on search
private _ctrlSearchBar = _controlsGroup controlsGroupCtrl IDC_SEARCH_BAR;
_ctrlSearchBar ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlSearchBar"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlSearchBar;
    [_controlsGroup] call FUNC(fillList);
}];

// Clear search when search bar is right clicked
_ctrlSearchBar ctrlAddEventHandler ["MouseButtonClick", {
    params ["_ctrlSearchBar", "_button"];

    if (_button != 1) exitWith {};

    _ctrlSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlSearchBar;

    private _controlsGroup = ctrlParentControlsGroup _ctrlSearchBar;
    [_controlsGroup] call FUNC(fillList);
}];

// Clear search when search button is clicked
private _ctrlButtonSearch = _controlsGroup controlsGroupCtrl IDC_BTN_SEARCH;
_ctrlButtonSearch ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonSearch"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlButtonSearch;
    private _ctrlSearchBar = _controlsGroup controlsGroupCtrl IDC_SEARCH_BAR;
    _ctrlSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlSearchBar;

    [_controlsGroup] call FUNC(fillList);
}];

// Add or remove items using the list buttons
private _ctrlButtonAdd = _controlsGroup controlsGroupCtrl IDC_BTN_ADD;
_ctrlButtonAdd ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonAdd"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlButtonAdd;
    [_controlsGroup, true] call FUNC(modify);
}];

private _ctrlButtonRemove = _controlsGroup controlsGroupCtrl IDC_BTN_REMOVE;
_ctrlButtonRemove ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonRemove"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlButtonRemove;
    [_controlsGroup, false] call FUNC(modify);
}];

// Add or remove items using keyboard
private _ctrlList = _controlsGroup controlsGroupCtrl IDC_LIST;
_ctrlList ctrlAddEventHandler ["SetFocus", {
    params ["_ctrlList"];

    private _display = ctrlParent _ctrlList;
    _display setVariable [QGVAR(listFocus), ctrlParentControlsGroup _ctrlList];
}];

_ctrlList ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlList"];

    private _display = ctrlParent _ctrlList;
    _display setVariable [QGVAR(listFocus), nil];
}];

private _display = ctrlParent _controlsGroup;
_display displayAddEventHandler ["KeyDown", {call FUNC(keyDown)}];

// Update add or remove buttons when list selection changes
_ctrlList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlList"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlList;
    [_controlsGroup] call FUNC(updateButtons);
}];

// Clear cargo from current category
private _ctrlButtonClear = _controlsGroup controlsGroupCtrl IDC_BTN_CLEAR;
_ctrlButtonClear ctrlAddEventHandler ["ButtonClick", {call FUNC(clear)}];

// Update the load bar for current load
[_controlsGroup] call FUNC(updateLoadBar);

// Populate the list with items
[_controlsGroup] call FUNC(fillList);
