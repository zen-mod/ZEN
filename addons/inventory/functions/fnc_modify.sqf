#include "script_component.hpp"
/*
 * Author: mharis001
 * Modifies the object's cargo by adding or removing items from it.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Mode (true: add, false: remove) <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, true] call zen_inventory_fnc_modify
 *
 * Public: No
 */

params ["_display", "_mode"];

// Get the amount of items to add/remove based on the mode
// Allow for items to be modified 1, 5, 10, or 50 at a time using shift and control
private _amount = [-1, 1] select _mode;

if (cba_events_shift) then {
    _amount = _amount * 5;
};

if (cba_events_control) then {
    _amount = _amount * 10;
};

// Get the currently selected item, its cargo entry, and its mass
// For weapons, the entry is the weapon items array so attachments and magazines are preserved
private _ctrlList = _display displayCtrl IDC_LIST;
private _currentRow = lnbCurSelRow _ctrlList;
(_display call FUNC(getSelected)) params ["_item", "_entry", "_mass"];

// Get the current and maximum load for the object
private _currentLoad = _display getVariable QGVAR(currentLoad);
private _maximumLoad = _display getVariable QGVAR(maximumLoad);

// Get the relevant cargo array based on the selected item
private _cargo = if (_entry isEqualType []) then {
    _display getVariable QGVAR(cargo) select CARGO_WEAPONS
} else {
    [_display, _item] call FUNC(getCargo)
};
_cargo params ["_types", "_counts"];

// Get the current amount of the item in cargo
private _index = _types find _entry;
private _count = _counts param [_index, 0];

// Ensure that the maximum load is not exceeded when adding items
if (_amount > 0 && _mass > 0) then {
    _amount = floor ((_maximumLoad - _currentLoad) / _mass) min _amount;
};

// Ensure that at most only the current amount of items are removed
if (_amount < 0) then {
    _amount = _amount max -_count;
};

// Update the cargo array to reflect the item's new count
_count = _count + _amount;

if (_count > 0) then {
    // Add item to types array if it does not already exist
    if (_index == -1) then {
        _index = _types pushBack _entry;
    };

    _counts set [_index, _count];
} else {
    // Remove the item from cargo if its count is now zero
    _types  deleteAt _index;
    _counts deleteAt _index;
};

// Update tracked containers if needed
private _isContainer = _item call EFUNC(common,isContainerItem);

if (_isContainer && {_amount != 0}) then {
    private _containers = _display getVariable [QGVAR(containers), []];

    if (_amount > 0) then {
        // Empty data preserves the config-defined inventory of newly added containers
        for "_i" from 1 to _amount do {
            _containers pushBack [_item, []];
        };
    } else {
        // Remove the most recently added/matched instance
        // LIFO gives useful semantics for adding and then removing (or vice versa)
        private _amountToRemove = -_amount;

        {
            _x params ["_containerType"];

            if (_containerType == _item) then {
                _containers deleteAt _forEachIndex;
                _amountToRemove = _amountToRemove - 1;

                if (_amountToRemove == 0) then {
                    break;
                };
            };
        } forEachReversed _containers;
    };
};

// Update the item's row in the list
private _alpha = [ALPHA_NONE, ALPHA_SOME] select (_count > 0);
_ctrlList lnbSetValue [[_currentRow, 2], _count];
_ctrlList lnbSetText  [[_currentRow, 2], str _count];
_ctrlList lnbSetColor [[_currentRow, 1], [1, 1, 1, _alpha]];
_ctrlList lnbSetColor [[_currentRow, 2], [1, 1, 1, _alpha]];

// Update the current load with the amount of items added/removed
_display setVariable [QGVAR(currentLoad), _currentLoad + _mass * _amount];

// Update other display elements
_display call FUNC(update);
