/*
 * Author: mharis001
 * Handles adding or removing items from cargo.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Add or Remove Item <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, true] call zen_inventory_fnc_modify
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display", "_addItem"];

// Get currently selected item and its mass
private _ctrlList = _display displayCtrl IDC_LIST;
private _currentRow = lnbCurSelRow _ctrlList;
private _item = _ctrlList lnbData [_currentRow, 0];
private _mass = [_item] call FUNC(getItemMass);

// Get current and max load for object
private _maxLoad = _display getVariable QGVAR(maxLoad);
private _currentLoad = _display getVariable QGVAR(currentLoad);

// Get relevant cargo list based on selected item
private _categoryCargo = [_display, _item] call FUNC(getCargo);
_categoryCargo params ["_cargoItems", "_cargoCounts"];

private _itemIndex = _cargoItems find _item;

if (_addItem && {_maxLoad - _currentLoad >= _mass}) then {
    private _count = 1;

    if (_itemIndex == -1) then {
        // Item is not in list, add item and count
        _cargoItems pushBack _item;
        _cargoCounts pushBack _count;
    } else {
        // Item is in list, increase count by one
        _count = (_cargoCounts select _itemIndex) + 1;
        _cargoCounts set [_itemIndex, _count];
    };

    _currentLoad = _currentLoad + _mass;

    // Update count text and increase alpha
    _ctrlList lnbSetText  [[_currentRow, 2], str _count];
    _ctrlList lnbSetColor [[_currentRow, 1], [1, 1, 1, 1]];
    _ctrlList lnbSetColor [[_currentRow, 2], [1, 1, 1, 1]];
};

if (!_addItem && {_itemIndex != -1}) then {
    private _count = (_cargoCounts select _itemIndex) - 1;

    if (_count > 0) then {
        // Count is not zero, update counts with new value
        _cargoCounts set [_itemIndex, _count];
    } else {
        // Count is now zero, remove item from list
        _cargoItems deleteAt _itemIndex;
        _cargoCounts deleteAt _itemIndex;
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
[_display] call FUNC(updateloadBar);
[_display] call FUNC(updateButtons);
