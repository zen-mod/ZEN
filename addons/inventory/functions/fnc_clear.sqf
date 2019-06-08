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
#include "script_component.hpp"

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
    private _categoryCargo = [_display] call FUNC(getCargo);
    _categoryCargo params ["_cargoItems", "_cargoCounts"];

    {
        private _itemIndex = _cargoItems find _x;
        _cargoItems deleteAt _itemIndex;
        _cargoCounts deleteAt _itemIndex;
    } forEach (_itemsList select _category);

    [_display] call FUNC(calculateLoad);
};

// Update the load bar for new load
[_display] call FUNC(updateLoadBar);

// Refresh the list after clearing
[_display] call FUNC(fillList);
