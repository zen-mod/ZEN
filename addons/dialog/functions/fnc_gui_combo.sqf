#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the COMBO content control.
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
 * [CONTROL, 0, 1] call zen_dialog_fnc_gui_combo
 *
 * Public: No
 */

params ["_controlsGroup", "_rowIndex", "_currentValue", "_rowSettings"];
_rowSettings params ["_values", "_labels"];

private _ctrlCombo = _controlsGroup controlsGroupCtrl IDC_ROW_COMBO;

{
    _x params ["_label", "_tooltip", "_picture", "_textColor"];

    private _index = _ctrlCombo lbAdd _label;
    _ctrlCombo lbSetTooltip [_index, _tooltip];
    _ctrlCombo lbSetPicture [_index, _picture];
    _ctrlCombo lbSetColor [_index, _textColor];
} forEach _labels;

_ctrlCombo lbSetCurSel (_values find _currentValue);

_ctrlCombo setVariable [QGVAR(params), [_rowIndex, _values]];

_ctrlCombo ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlCombo", "_index"];
    (_ctrlCombo getVariable QGVAR(params)) params ["_rowIndex", "_lbData"];

    private _display = ctrlParent _ctrlCombo;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _lbData select _index];
}];
