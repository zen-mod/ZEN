#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clearing all items from the current category.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_inventory_fnc_clear
 *
 * Public: No
 */

params ["_ctrlButtonClear"];

private _display = ctrlParent _ctrlButtonClear;
private _category = lbCurSel (_display displayCtrl IDC_CATEGORY) - 1;

if (_category == -1) then {
    // No specific category, empty cargo completely
    _display setVariable [QGVAR(cargo), EMPTY_CARGO];
    _display setVariable [QGVAR(currentLoad), 0];
} else {
    // Remove category items from cargo
    private _itemsList = uiNamespace getVariable QGVAR(itemsList);
    (_display call FUNC(getCargo)) params ["_types", "_counts"];

    {
        private _index = _types find _x;
        _types  deleteAt _index;
        _counts deleteAt _index;
    } forEach (_itemsList select _category);

    // Recalculate the current load of the inventory
    private _cargo = _display getVariable QGVAR(cargo);
    _display setVariable [QGVAR(currentLoad), [_cargo] call FUNC(calculateLoad)];
};

// Update the load bar for the new load
[_display] call FUNC(updateLoadBar);

// Refresh the list after clearing
[_display] call FUNC(refreshList);
