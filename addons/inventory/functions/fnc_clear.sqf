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

private _controlsGroup = ctrlParentControlsGroup _ctrlButtonClear;
private _category = lbCurSel (_controlsGroup controlsGroupCtrl IDC_CATEGORY) - 1;

if (_category == -1) then {
    // No specific category, empty cargo completely
    _controlsGroup setVariable [QEGVAR(attributes,value), EMPTY_CARGO];
    _controlsGroup setVariable [QGVAR(currentLoad), 0];
} else {
    // Remove category items from cargo
    private _itemsList = uiNamespace getVariable QGVAR(itemsList);
    private _categoryCargo = [_controlsGroup] call FUNC(getCargo);
    _categoryCargo params ["_cargoItems", "_cargoCounts"];

    {
        private _itemIndex = _cargoItems find _x;
        _cargoItems deleteAt _itemIndex;
        _cargoCounts deleteAt _itemIndex;
    } forEach (_itemsList select _category);

    [_controlsGroup] call FUNC(calculateLoad);
};

// Update the load bar for new load
[_controlsGroup] call FUNC(updateLoadBar);

// Refresh the list after clearing
[_controlsGroup] call FUNC(fillList);
