#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "checkboxes" attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <ARRAY>
 * 2: Value Info <ARRAY>
 *   0: Check Boxes <NUMBER>
 *     N: [X Position <NUMBER>, Y Position <NUMBER>, Width <NUMBER>, Text <STRING>, Tooltip <STRING>] <ARRAY>
 *   1: Height <NUMBER>
 *   2: Hide Label <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_controlsGroup, _defaultValue, _valueInfo] call zen_attributes_fnc_gui_checkboxes
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue", "_valueInfo"];
_valueInfo params [["_checkboxes", [], [[]]], ["_height", 1, [0]], ["_hideLabel", false, [false]]];

private _display = ctrlParent _controlsGroup;
private _controls = [];

{
    _x params [["_posX", 0, [0]], ["_posY", 0, [0]], ["_width", 16, [0]], ["_text", "", [""]], ["_tooltip", "", [""]]];

    private _ctrlCheckbox = _display ctrlCreate ["ctrlCheckbox", -1, _controlsGroup];
    _ctrlCheckbox ctrlSetPosition [POS_W(_posX), POS_H(_posY), POS_W(1), POS_H(1)];
    _ctrlCheckbox ctrlCommit 0;

    private _checked = _defaultValue param [_forEachIndex, false, [false]];
    _ctrlCheckbox cbSetChecked _checked;

    if (isLocalized _text) then {
        _text = localize _text;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    private _ctrlText = _display ctrlCreate ["ctrlStatic", -1, _controlsGroup];
    _ctrlText ctrlSetPosition [POS_W(_posX + 0.8), POS_H(_posY), POS_W(_width - 0.8), POS_H(1)];
    _ctrlText ctrlSetFontHeight POS_H(0.85);
    _ctrlText ctrlSetTooltip _tooltip;
    _ctrlText ctrlSetText _text;
    _ctrlText ctrlCommit 0;

    _ctrlCheckbox setVariable [QGVAR(params), [_forEachIndex, _controls]];
    _controls pushBack _ctrlCheckbox;

    _ctrlCheckbox ctrlAddEventHandler ["CheckedChanged", {
        params ["_ctrlCheckbox", "_state"];
        (_ctrlCheckbox getVariable QGVAR(params)) params ["_index", "_controls"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlCheckbox;
        private _value = _controlsGroup getVariable QGVAR(value);

        // On initial value change, get the checked state of all checkboxes
        if (isNil "_value") exitWith {
            _value = _controls apply {cbChecked _x};
            _controlsGroup setVariable [QGVAR(value), _value];
        };

        _value set [_index, _state == 1];
    }];
} forEach _checkboxes;

private _ctrlLabel = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_LABEL;
private _ctrlBackground = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_BACKGROUND;

if (_height > 1) then {
    private _height = _height * (ctrlPosition _controlsGroup select 3);
    _controlsGroup ctrlSetPositionH _height;
    _controlsGroup ctrlCommit 0;

    _ctrlLabel ctrlSetPositionH _height;
    _ctrlLabel ctrlCommit 0;

    _ctrlBackground ctrlSetPositionH _height;
    _ctrlBackground ctrlCommit 0;
};

if (_hideLabel) then {
    _ctrlLabel ctrlShow false;

    _ctrlBackground ctrlSetPositionX 0;
    _ctrlBackground ctrlSetPositionW POS_W(26);
    _ctrlBackground ctrlCommit 0;
};
