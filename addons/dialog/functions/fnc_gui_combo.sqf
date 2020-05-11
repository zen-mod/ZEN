#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the COMBO content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <ANY>
 * 2: Settings <ARRAY>
 *   0: Entries <ARRAY>
 *     N: [Value <ANY>, Text <STRING>, Tooltip <STRING>, Picture <STRING>, Text Color <ARRAY>] <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, [_entries]] call zen_dialog_fnc_gui_combo
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue", "_settings"];
_settings params ["_entries"];

private _ctrlCombo = _controlsGroup controlsGroupCtrl IDC_ROW_COMBO;

{
    _x params ["_value", "_text", "_tooltip", "_picture", "_textColor"];

    private _index = _ctrlCombo lbAdd _text;
    _ctrlCombo lbSetTooltip [_index, _tooltip];
    _ctrlCombo lbSetPicture [_index, _picture];
    _ctrlCombo lbSetColor [_index, _textColor];
    _ctrlCombo setVariable [str _index, _value];

    if (_value isEqualTo _defaultValue) then {
        _ctrlCombo lbSetCurSel _index;
    };
} forEach _entries;

_controlsGroup setVariable [QFUNC(value), {
    params ["_controlsGroup"];

    private _ctrlCombo = _controlsGroup controlsGroupCtrl IDC_ROW_COMBO;
    _ctrlCombo getVariable str lbCurSel _ctrlCombo
}];
