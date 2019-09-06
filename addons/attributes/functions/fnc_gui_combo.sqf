#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the `combo` attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Entity <OBJECT|GROUP|ARRAY|STRING>
 * 2: Default Value <STRING>
 * 3: Value Info <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, _entity, "", []] call zen_attributes_fnc_gui_combo
 *
 * Public: No
 */

params ["_controlsGroup", "_entity", "_defaultValue", "_valueInfo"];

private _ctrlCombo = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_COMBO;
_ctrlCombo setVariable [QGVAR(params), [_controlsGroup]];

{
    _x params ["_value", "_displayName", ["_tooltip", "", [""]], ["_pictureArg", "", ["", []]]];
    _pictureArg params [["_picture", "", [""]], ["_pictureColor", [1, 1, 1, 1], [[]], [4]]];

    if (isLocalized _displayName) then {
        _displayName = localize _displayName;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    private _index = _ctrlCombo lbAdd _displayName;
    _ctrlCombo lbSetTooltip [_index, _tooltip];
    _ctrlCombo lbSetPicture [_index, _picture];
    _ctrlCombo lbSetPictureColor [_index, _pictureColor];
    _ctrlCombo lbSetPictureColorSelected [_index, _pictureColor];
    _ctrlCombo setVariable [str _index, _value];

    if (_value isEqualTo _defaultValue) then {
        _ctrlCombo lbSetCurSel _index;
    };
} forEach _valueInfo;

_ctrlCombo ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlCombo", "_index"];
    (_ctrlCombo getVariable QGVAR(params)) params ["_controlsGroup"];

    private _value = _ctrlCombo getVariable str _index;
    _controlsGroup setVariable [QGVAR(value), _value];
}];
