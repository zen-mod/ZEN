#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the `edit` attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Entity <OBJECT|GROUP|ARRAY|STRING>
 * 2: Default Value <STRING>
 * 3: Value Info <ARRAY>
 *   0: Sanitizing Function <CODE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_controlsGroup, _entity, "", [{_this}]] call zen_attributes_fnc_gui_edit
 *
 * Public: No
 */

params ["_controlsGroup", "_entity", "_defaultValue", "_valueInfo"];
_valueInfo params [["_fnc_sanitizeValue", {_this}, [{}]]];

private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_EDIT;
_ctrlEdit setVariable [QGVAR(params), [_controlsGroup, _fnc_sanitizeValue]];
_ctrlEdit ctrlSetText _defaultValue;

private _fnc_update = {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_controlsGroup", "_fnc_sanitizeValue"];

    private _value = ctrlText _ctrlEdit call _fnc_sanitizeValue;
    _controlsGroup setVariable [QGVAR(value), _value];
    _ctrlEdit ctrlSetText _value;
};

_ctrlEdit ctrlAddEventHandler ["KeyDown", _fnc_update];
_ctrlEdit ctrlAddEventHandler ["KeyUp", _fnc_update];
