#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the EDIT content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <STRING>
 * 2: Settings <ARRAY>
 *   0: Sanitizing Function <CODE>
 *   1: Is Multi <BOOL>
 *   2: Height <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, "123", [{_this}, false, 1]] call zen_dialog_fnc_gui_edit
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue", "_settings"];
_settings params ["_fnc_sanitizeValue", "_isMulti", "_height"];

private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ROW_EDIT;

// Adjust the height of multi-line edit boxes
if (_isMulti) then {
    _controlsGroup ctrlSetPositionH POS_H(_height + 1);
    _controlsGroup ctrlCommit 0;

    _ctrlEdit ctrlSetPositionH POS_H(_height);
    _ctrlEdit ctrlCommit 0;
};

// Format text using sanitizing function whenever it is changed
private _fnc_textChanged = {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_fnc_sanitizeValue"];

    private _text = ctrlText _ctrlEdit call _fnc_sanitizeValue;
    _ctrlEdit ctrlSetText _text;
};

_ctrlEdit ctrlAddEventHandler ["KeyDown", _fnc_textChanged];
_ctrlEdit ctrlAddEventHandler ["KeyUp", _fnc_textChanged];
_ctrlEdit setVariable [QGVAR(params), _fnc_sanitizeValue];
_ctrlEdit ctrlSetText _defaultValue;

_controlsGroup setVariable [QFUNC(value), {
    params ["_controlsGroup"];

    ctrlText (_controlsGroup controlsGroupCtrl IDC_ROW_EDIT)
}];
