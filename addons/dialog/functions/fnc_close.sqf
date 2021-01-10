#include "script_component.hpp"
/*
 * Author: mharis001
 * Closes the given dialog. Handles calling the appropriate confirm/cancel function and saving values.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Confirmed <BOOL>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, true] call zen_dialog_fnc_close
 *
 * Public: No
 */

params ["_display", "_confirmed"];

(_display getVariable QGVAR(params)) params ["_controls", "_onConfirm", "_onCancel", "_args", "_saveID"];

// Get the values of all content controls
private _values = _controls apply {
    _x params ["_controlsGroup", "_settings"];

    [_controlsGroup, _settings] call (_controlsGroup getVariable QFUNC(value))
};

// Call the appropriate confirm/cancel function
if (_confirmed) then {
    // Save values when the selections are confirmed
    // Make a copy to prevent issues from the values array being modified by reference
    GVAR(saved) setVariable [_saveID, +_values];

    [_values, _args] call _onConfirm;
} else {
    [_values, _args] call _onCancel;
};

[QGVAR(close), [_display, _confirmed]] call CBA_fnc_localEvent;

// Close dialog, returning false to not override engine driven IDC_OK and IDC_CANCEL
false
