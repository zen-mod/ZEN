/*
 * Author: mharis001
 * Initializes the LIST content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Row Index <NUMBER>
 * 2: Current Value <ANY>
 * 3: Row Settings <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, 1] call zen_dialog_fnc_gui_list
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_controlsGroup", "_rowIndex", "_currentValue", "_rowSettings"];
_rowSettings params ["_values", "_labels", "_height"];

private _ctrlList = _controlsGroup controlsGroupCtrl IDC_ROW_LIST;

// Adjust height of list based on row settings
_controlsGroup ctrlSetPositionH POS_H(_height + 1);
_controlsGroup ctrlCommit 0;

_ctrlList ctrlSetPositionH POS_H(_height);
_ctrlList ctrlCommit 0;

{
    _x params ["_label", "_tooltip", "_picture", "_textColor"];

    private _index = _ctrlList lbAdd _label;
    _ctrlList lbSetTooltip [_index, _tooltip];
    _ctrlList lbSetPicture [_index, _picture];
    _ctrlList lbSetColor [_index, _textColor];
} forEach _labels;

_ctrlList lbSetCurSel (_values find _currentValue);

_ctrlList setVariable [QGVAR(params), [_rowIndex, _values]];

_ctrlList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlList", "_index"];
    (_ctrlList getVariable QGVAR(params)) params ["_rowIndex", "_lbData"];

    private _display = ctrlParent _ctrlList;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _lbData select _index];
}];
