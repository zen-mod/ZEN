/*
 * Author: mharis001
 * Initializes the TOOLBOX content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Row Index <NUMBER>
 * 2: Current Value <NUMBER|BOOL>
 * 3: Row Settings <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, true, [true, 1, 2, ["No", "Yes"], 1, false]] call zen_dialog_fnc_gui_toolbox
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_controlsGroup", "_rowIndex", "_currentValue", "_rowSettings"];
_rowSettings params ["_returnBool", "_rows", "_columns", "_strings", "_height", "_isWide"];

GVAR(toolboxRows) = _rows;
GVAR(toolboxColumns) = _columns;

// Create the toolbox control
private _ctrlToolbox = ctrlParent _controlsGroup ctrlCreate [QGVAR(RscToolbox), IDC_ROW_TOOLBOX, _controlsGroup];
private _ctrlName = _controlsGroup controlsGroupCtrl IDC_ROW_NAME;

// Adjust the toolbox and label positions based on if this is the wide variant
if (_isWide) then {
    _ctrlToolbox ctrlSetPosition [0, POS_H(1), POS_W(26), POS_H(_height)];
    _ctrlName ctrlSetPositionW POS_W(26);

    // Extra height for controls group in wide variant
    _height = _height + 1;
} else {
    _ctrlToolbox ctrlSetPositionH POS_H(_height);
    _ctrlName ctrlSetPositionH POS_H(_height);
};

_ctrlToolbox ctrlCommit 0;
_ctrlName ctrlCommit 0;

// Adjust the height of the controls group
_controlsGroup ctrlSetPositionH POS_H(_height);
_controlsGroup ctrlCommit 0;

// Currently the only way to add options to toolbox controls through script
{
    _ctrlToolbox lbAdd _x;
} forEach _strings;

// Need number to set current index
if (_returnBool) then {
    _currentValue = parseNumber _currentValue;
};

_ctrlToolbox lbSetCurSel _currentValue;

_ctrlToolbox setVariable [QGVAR(params), [_rowIndex, _returnBool]];

_ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlToolbox", "_value"];
    (_ctrlToolbox getVariable QGVAR(params)) params ["_rowIndex", "_returnBool"];

    if (_returnBool) then {
        _value = _value > 0;
    };

    private _display = ctrlParent _ctrlToolbox;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _value];
}];
