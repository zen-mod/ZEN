#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the TOOLBOX content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <NUMBER|BOOL>
 * 2: Settings <ARRAY>
 *   0: Return Bool <BOOL>
 *   1: Rows <NUMBER>
 *   2: Columns <NUMBER>
 *   3: Strings <ARRAY>
 *   4: Height <NUMBER>
 *   5: Is Wide <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, true, [true, 1, 2, ["No", "Yes"], 1, false]] call zen_dialog_fnc_gui_toolbox
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue", "_settings"];
_settings params ["", "_rows", "_columns", "_strings", "_height", "_isWide"];

private _display = ctrlParent _controlsGroup;
parsingNamespace setVariable [QEGVAR(common,rows), _rows max 1];
parsingNamespace setVariable [QEGVAR(common,columns), _columns max 1];

// Create the toolbox control and add the entries
private _ctrlToolbox = _display ctrlCreate [QEGVAR(common,RscToolbox), IDC_ROW_TOOLBOX, _controlsGroup];

{
    _x params ["_text", "_tooltip"];

    private _index = _ctrlToolbox lbAdd _text;
    _ctrlToolbox lbSetTooltip [_index, _tooltip];
} forEach _strings;

// Convert boolean default values to a toolbox index
if (_defaultValue isEqualType false) then {
    _defaultValue = parseNumber _defaultValue;
};

_ctrlToolbox lbSetCurSel _defaultValue;

// Adjust the toolbox and label positions based on if this is the wide variant
private _ctrlLabel = _controlsGroup controlsGroupCtrl IDC_ROW_LABEL;

if (_isWide) then {
    _ctrlToolbox ctrlSetPosition [0, POS_H(1), POS_W(26), POS_H(_height)];
    _ctrlLabel ctrlSetPositionW POS_W(26);

    // Extra height for controls group in wide variant
    _height = _height + 1;
} else {
    _ctrlToolbox ctrlSetPositionH POS_H(_height);
    _ctrlLabel ctrlSetPositionH POS_H(_height);
};

_ctrlToolbox ctrlCommit 0;
_ctrlLabel ctrlCommit 0;

// Adjust the height of the controls group
_controlsGroup ctrlSetPositionH POS_H(_height);
_controlsGroup ctrlCommit 0;

_controlsGroup setVariable [QFUNC(value), {
    params ["_controlsGroup", "_settings"];
    _settings params ["_returnBool"];

    private _value = lbCurSel (_controlsGroup controlsGroupCtrl IDC_ROW_TOOLBOX);

    if (_returnBool) then {
        _value = _value > 0;
    };

    _value
}];
