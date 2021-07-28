#include "script_component.hpp"
/*
 * Author: mharis001
 * Clears all items from the current category.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_clear
 *
 * Public: No
 */

params ["_display"];

private _fnc_clear = {
    params ["_items"];

    (_display call FUNC(getCargo)) params ["_types", "_counts"];

    {
        private _index = _types find _x;
        _types  deleteAt _index;
        _counts deleteAt _index;
    } forEach _items;

    private _cargo = _display getVariable QGVAR(cargo);
    _display setVariable [QGVAR(currentLoad), [_cargo] call FUNC(calculateLoad)];
};

if (_display getVariable [QGVAR(weapon), ""] == "") then {
    private _category = lbCurSel (_display displayCtrl IDC_CATEGORY) - 1;

    if (_category == -1) then {
        // No specific category, empty cargo completely
        _display setVariable [QGVAR(cargo), EMPTY_CARGO];
        _display setVariable [QGVAR(currentLoad), 0];
    } else {
        // Specific category selected, get items to remove from the master items list
        private _items = uiNamespace getVariable QGVAR(itemsList) select _category;
        [_items] call _fnc_clear;
    };
} else {
    // In weapon specific mode, clear items compatible with the selected weapon
    private _items = _display call FUNC(getWeaponItems);
    [_items] call _fnc_clear;
};

// Refresh the list after clearing
_display call FUNC(refresh);
