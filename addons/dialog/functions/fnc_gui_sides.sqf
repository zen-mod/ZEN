#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the SIDES content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <SIDE|ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, west] call zen_dialog_fnc_gui_sides
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue"];

// Make a copy of multi-select side arrays
// It could be a saved value and the common sides control modifies it by reference
if (_defaultValue isEqualType []) then {
    _defaultValue = +_defaultValue;
};

private _ctrlSides = _controlsGroup controlsGroupCtrl IDC_ROW_SIDES;
[_ctrlSides, _defaultValue] call EFUNC(common,initSidesControl);

_controlsGroup setVariable [QFUNC(value), {
    params ["_controlsGroup"];

    private _ctrlSides = _controlsGroup controlsGroupCtrl IDC_ROW_SIDES;
    _ctrlSides getVariable QEGVAR(common,value)
}];
