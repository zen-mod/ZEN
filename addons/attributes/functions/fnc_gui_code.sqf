#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "code" attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <STRING>
 * 2: Value Info <ARRAY>
 *   0: History Variable Name <STRING>
 *   1: Mode Variable Name <STRING>
 *   2: Editbox Tooltip <STRING>
 *   3: Maximum Statements <NUMBER>
 *   4: Maximum Characters <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_controlsGroup, _defaultValue, _valueInfo] call zen_attributes_fnc_gui_code
 *
 * Public: No
 */

#define PREVIEW_LENGTH 30

params ["_controlsGroup", "_defaultValue", "_valueInfo"];
_valueInfo params [["_historyVarName", "", [""]], ["_modeVarName", "", [""]], ["_editboxTooltip", "", [""]], ["_maxStatements", 20, [0]], ["_maxCharacters", -1, [0]]];

if (isLocalized _editboxTooltip) then {
    _editboxTooltip = localize _editboxTooltip;
};

private _ctrlCombo = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_COMBO;
_ctrlCombo setVariable [QGVAR(params), [_historyVarName]];
_ctrlCombo lbAdd localize "STR_A3_RscAttributeTaskDescription_New";
_ctrlCombo lbSetCurSel 0;

{
    // Shorten long statements and add "..." to the end
    if (count _x > PREVIEW_LENGTH) then {
        _x = format ["%1%2", _x select [0, PREVIEW_LENGTH], toString [ASCII_PERIOD, ASCII_PERIOD, ASCII_PERIOD]];
    };

    _ctrlCombo lbAdd _x;
} forEach (profileNamespace getVariable [_historyVarName, []]);

_ctrlCombo ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlCombo", "_index"];
    (_ctrlCombo getVariable QGVAR(params)) params ["_historyVarName"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlCombo;

    private _text = if (_index > 0) then {
        private _history = profileNamespace getVariable [_historyVarName, []];
        _history select (_index - 1)
    } else {
        "" // New
    };

    private _ctrlMode = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_MODE;
    private _mode = _ctrlMode getVariable QGVAR(mode);

    private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_EDIT;
    _ctrlEdit ctrlSetText _text;

    _controlsGroup setVariable [QGVAR(value), [_text, _mode]];
}];

private _ctrlMode = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_MODE;
_ctrlMode ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlMode"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlMode;

    private _mode = _ctrlMode getVariable QGVAR(mode);
    _mode = [MODE_TARGET, MODE_GLOBAL, MODE_LOCAL] select _mode;

    private _fnc_updateModeButton = _ctrlMode getVariable QFUNC(updateModeButton);
    [_ctrlMode, _mode] call _fnc_updateModeButton;

    private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_EDIT;
    private _text = ctrlText _ctrlEdit;

    _controlsGroup setVariable [QGVAR(value), [_text, _mode]];
}];

private _fnc_updateModeButton = {
    params ["_ctrlMode", "_mode"];

    private _icon = [
        "\a3\ui_f\data\igui\cfg\simpletasks\letters\l_ca.paa",
        "\a3\ui_f\data\igui\cfg\simpletasks\letters\t_ca.paa",
        "\a3\ui_f\data\igui\cfg\simpletasks\letters\g_ca.paa"
    ] select _mode;

    private _tooltip = [LSTRING(LocalExec), LSTRING(TargetExec), LSTRING(GlobalExec)] select _mode;

    _ctrlMode ctrlSetText _icon;
    _ctrlMode ctrlSetTooltip localize _tooltip;
    _ctrlMode setVariable [QGVAR(mode), _mode];
};

_ctrlMode setVariable [QFUNC(updateModeButton), _fnc_updateModeButton];

private _mode = profileNamespace getVariable [_modeVarName, MODE_TARGET];
[_ctrlMode, _mode] call _fnc_updateModeButton;

private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_EDIT;
_ctrlEdit ctrlSetTooltip _editboxTooltip;
_ctrlEdit ctrlSetText _defaultValue;

_ctrlEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEdit"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlEdit;

    private _ctrlMode = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_MODE;
    private _mode = _ctrlMode getVariable QGVAR(mode);

    _controlsGroup setVariable [QGVAR(value), [ctrlText _ctrlEdit, _mode]];
}];

// Save code history and mode on confirm
_controlsGroup setVariable [QGVAR(params), [_historyVarName, _modeVarName, _maxStatements, _maxCharacters]];

_controlsGroup setVariable [QFUNC(onConfirm), {
    params ["_controlsGroup"];
    (_controlsGroup getVariable QGVAR(params)) params ["_historyVarName", "_modeVarName", "_maxStatements", "_maxCharacters"];

    private _value = _controlsGroup getVariable QGVAR(value);
    if (isNil "_value") exitWith {};

    _value params ["_text", "_mode"];

    profileNamespace setVariable [_modeVarName, _mode];

    // Do not save empty strings and strings that are longer that the maximum number of characters
    if (_text == "" || {_maxCharacters > 0 && {count _text > _maxCharacters}}) exitwith {};

    private _history = profileNamespace getVariable [_historyVarName, []];
    _history deleteAt (_history find _text);

    // Push front
    reverse _history;
    _history pushBack _text;
    reverse _history;

    if (count _history > _maxStatements) then {
        _history resize _maxStatements;
    };

    profileNamespace setVariable [_historyVarName, _history];
}];
