#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the CHECKBOX content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Row Index <NUMBER>
 * 2: Current Value <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, true] call zen_dialog_fnc_gui_checkbox
 *
 * Public: No
 */

params ["_controlsGroup", "_rowIndex", "_currentValue"];

private _ctrlCheckbox = _controlsGroup controlsGroupCtrl IDC_ROW_CHECKBOX;
_ctrlCheckbox cbSetChecked _currentValue;

_ctrlCheckbox setVariable [QGVAR(params), [_rowIndex]];
_ctrlCheckbox ctrlAddEventHandler ["CheckedChanged", {
    params ["_ctrlCheckbox", "_state"];
    (_ctrlCheckbox getVariable QGVAR(params)) params ["_rowIndex"];

    private _display = ctrlParent _ctrlCheckbox;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _state == 1];
}];
