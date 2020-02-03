#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "combo" attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <ANY>
 * 2: Value Info <ARRAY>
 *   0: Entries <ARRAY>
 *     N: [Value <ANY>, Text and Tooltip <STRING|ARRAY>, Picture and Color <STRING|ARRAY>] <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_controlsGroup, _defaultValue, _valueInfo] call zen_attributes_fnc_gui_combo
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue", "_valueInfo"];
_valueInfo params [["_entries", [], [[]]]];

private _ctrlCombo = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_COMBO;

{
    _x params [["_value", _forEachIndex], ["_name", "", ["", []]], ["_icon", "", ["", []]]];
    _name params [["_text", "", [""]], ["_tooltip", "", [""]]];
    _icon params [["_picture", "", [""]], ["_pictureColor", [1, 1, 1, 1], [[]], 4]];

    if (isLocalized _text) then {
        _text = localize _text;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    private _index = _ctrlCombo lbAdd _text;
    _ctrlCombo lbSetTooltip [_index, _tooltip];
    _ctrlCombo lbSetPicture [_index, _picture];
    _ctrlCombo lbSetPictureColor [_index, _pictureColor];
    _ctrlCombo lbSetPictureColorSelected [_index, _pictureColor];
    _ctrlCombo setVariable [str _index, _value];

    if (_value isEqualTo _defaultValue) then {
        _ctrlCombo lbSetCurSel _index;
    };
} forEach _entries;

_ctrlCombo ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlCombo", "_index"];

    private _value = _ctrlCombo getVariable str _index;

    private _controlsGroup = ctrlParentControlsGroup _ctrlCombo;
    _controlsGroup setVariable [QGVAR(value), _value];
}];
