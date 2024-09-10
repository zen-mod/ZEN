#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the CHECKBOX content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, true] call zen_dialog_fnc_gui_checkbox
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue"];

private _ctrlCheckbox = _controlsGroup controlsGroupCtrl IDC_ROW_CHECKBOX;
_ctrlCheckbox cbSetChecked _defaultValue;

_controlsGroup setVariable [QFUNC(value), {
    params ["_controlsGroup"];

    cbChecked (_controlsGroup controlsGroupCtrl IDC_ROW_CHECKBOX)
}];
