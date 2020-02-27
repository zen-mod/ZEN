#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles adding or removing items from cargo.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Add or Remove <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, true] call zen_inventory_fnc_modify
 *
 * Public: No
 */

params ["_display", "_addItem"];

// Get currently selected item and its mass
private _ctrlList = _display displayCtrl IDC_LIST;
private _currentRow = lnbCurSelRow _ctrlList;
private _item = _ctrlList lnbData [_currentRow, 0];
private _mass = [_item] call FUNC(getItemMass);

// Get current and maximum load for object
private _currentLoad = _display getVariable QGVAR(currentLoad);
private _maximumLoad = _display getVariable QGVAR(maximumLoad);

// Get relevant cargo list based on selected item
private _cargo = [_display, _item] call FUNC(getCargo);
_cargo params ["_types", "_counts"];

private _index = _types find _item;

if (_addItem && {_maximumLoad - _currentLoad >= _mass}) then {
    private _count = 1;

    if (_index == -1) then {
        // Item is not in list, add item and count
        _types  pushBack _item;
        _counts pushBack _count;
    } else {
        // Item is in list, increase the count
        _count = (_counts select _index) + 1;
        _counts set [_index, _count];
    };

    _currentLoad = _currentLoad + _mass;

    // Update count text and increase alpha
    _ctrlList lnbSetText  [[_currentRow, 2], str _count];
    _ctrlList lnbSetColor [[_currentRow, 1], [1, 1, 1, 1]];
    _ctrlList lnbSetColor [[_currentRow, 2], [1, 1, 1, 1]];
};

if (!_addItem && {_index != -1}) then {
    private _count = (_counts select _index) - 1;

    if (_count > 0) then {
        // Count is not zero, update counts with new value
        _counts set [_index, _count];
    } else {
        // Count is now zero, remove item from list
        _types  deleteAt _index;
        _counts deleteAt _index;
    };

    _currentLoad = _currentLoad - _mass;

    // Update count text and decrease alpha if new count is zero
    private _alpha = [0.5, 1] select (_count != 0);
    _ctrlList lnbSetText  [[_currentRow, 2], str _count];
    _ctrlList lnbSetColor [[_currentRow, 1], [1, 1, 1, _alpha]];
    _ctrlList lnbSetColor [[_currentRow, 2], [1, 1, 1, _alpha]];
};

_display setVariable [QGVAR(currentLoad), _currentLoad];

// Update the load bar and list buttons
[_display] call FUNC(updateLoadBar);
[_display] call FUNC(updateButtons);
