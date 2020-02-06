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
 *   1: Editbox Tooltip <STRING>
 *   2: Maximum Statements <NUMBER>
 *   3: Maximum Characters <NUMBER>
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
_valueInfo params [["_historyVarName", "", [""]], ["_editboxTooltip", "", [""]], ["_maxStatements", 20, [0]], ["_maxCharacters", -1, [0]]];

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

    private _text = if (_index > 0) then {
        private _history = profileNamespace getVariable [_historyVarName, []];
        _history select (_index - 1)
    } else {
        "" // New
    };

    private _controlsGroup = ctrlParentControlsGroup _ctrlCombo;
    _controlsGroup setVariable [QGVAR(value), _text];

    private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_EDIT;
    _ctrlEdit ctrlSetText _text;
}];

private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_EDIT;
_ctrlEdit ctrlSetTooltip _editboxTooltip;
_ctrlEdit ctrlSetText _defaultValue;

_ctrlEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEdit"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlEdit;
    _controlsGroup setVariable [QGVAR(value), ctrlText _ctrlEdit];
}];

// Save code history if a variable name is given
if (_historyVarName != "") then {
    _controlsGroup setVariable [QGVAR(params), [_historyVarName, _maxStatements, _maxCharacters]];

    _controlsGroup setVariable [QFUNC(onConfirm), {
        params ["_controlsGroup"];
        (_controlsGroup getVariable QGVAR(params)) params ["_historyVarName", "_maxStatements", "_maxCharacters"];

        // Do not save empty strings and strings that are longer that the maximum number of characters
        private _value = _controlsGroup getVariable [QGVAR(value), ""];
        if (_value == "" || {_maxCharacters > 0 && {count _value > _maxCharacters}}) exitwith {};

        private _history = profileNamespace getVariable [_historyVarName, []];
        _history deleteAt (_history find _value);

        // Push front
        reverse _history;
        _history pushBack _value;
        reverse _history;

        if (count _history > _maxStatements) then {
            _history resize _maxStatements;
        };

        profileNamespace setVariable [_historyVarName, _history];
    }];
};
