#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the confirm button.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_dialog_fnc_gui_confirm
 *
 * Public: No
 */

params ["_ctrlButtonOK"];

private _display = ctrlParent _ctrlButtonOK;
private _values = _display getVariable QGVAR(values);
(_display getVariable QGVAR(params)) params ["_onConfirm", "", "_arguments", "_saveId"];

{
    private _valueId = [_saveId, _forEachIndex] joinString "$";
    GVAR(saved) setVariable [_valueId, _x];
} forEach _values;

[_values, _arguments] call _onConfirm;

closeDialog 0;
