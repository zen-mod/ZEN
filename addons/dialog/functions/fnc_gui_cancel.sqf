#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the cancel button.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_dialog_fnc_gui_cancel
 *
 * Public: No
 */

params ["_ctrlButtonCancel"];

private _display = ctrlParent _ctrlButtonCancel;
private _values = _display getVariable QGVAR(values);
(_display getVariable QGVAR(params)) params ["", "_onCancel", "_arguments"];

[_values, _arguments] call _onCancel;

_display closeDisplay IDC_CANCEL;
