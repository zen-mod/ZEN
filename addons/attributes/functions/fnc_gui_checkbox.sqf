#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the `checkbox` attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Entity <OBJECT|GROUP|ARRAY|STRING>
 * 2: Default Value <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_controlsGroup, _entity, true] call zen_attributes_fnc_gui_checkbox
 *
 * Public: No
 */

params ["_controlsGroup", "_entity", "_defaultValue"];

private _ctrlCheckBox = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_CHECKBOX;
_ctrlCheckBox setVariable [QGVAR(params), [_controlsGroup]];
_ctrlCheckbox cbSetChecked _defaultValue;

_ctrlCheckbox ctrlAddEventHandler ["CheckedChanged", {
    params ["_ctrlCheckbox", "_state"];
    (_ctrlCheckbox getVariable QGVAR(params)) params ["_controlsGroup"];

    _controlsGroup setVariable [QGVAR(value), _state == 1];
}];
