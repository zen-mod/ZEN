#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "loiter" attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_controlsGroup, _defaultValue] call zen_attributes_fnc_gui_loiter
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue"];

private _ctrlToolbox = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_TOOLBOX;
_ctrlToolbox lbSetCurSel parseNumber (_defaultValue == "CIRCLE");

_ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlToolbox", "_value"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlToolbox;
    _controlsGroup setVariable [QGVAR(value), ["CIRCLE_L", "CIRCLE"] select _value];
}];
