#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Waypoint Timeout" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeWaypointTimeout
 *
 * Public: No
 */

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _timeout = random waypointTimeout _entity;

private _ctrlSlider = _display displayCtrl IDC_TIMEOUT_SLIDER;
_ctrlSlider sliderSetRange [0, 1800];
_ctrlSlider sliderSetSpeed [15, 30];
_ctrlSlider sliderSetPosition _timeout;

private _fnc_onSliderPosChanged = {
    params ["_ctrlSlider", "_value"];

    private _display = ctrlParent _ctrlSlider;
    _display setVariable [QGVAR(waypointTimeout), _value];

    private _ctrlEdit = _display displayCtrl IDC_TIMEOUT_EDIT;
    _ctrlEdit ctrlSetText FORMAT_ROUND(_value);
};

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", _fnc_onSliderPosChanged];

private _ctrlEdit = _display displayCtrl IDC_TIMEOUT_EDIT;
_ctrlEdit ctrlSetText FORMAT_ROUND(_timeout);

private _fnc_onKeyUp = {
    params ["_ctrlEdit"];

    private _display = ctrlParent _ctrlEdit;
    private _value = parseNumber ctrlText _ctrlEdit;

    private _ctrlSlider = _display displayCtrl IDC_TIMEOUT_SLIDER;
    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    _display setVariable [QGVAR(waypointTimeout), _value];
};

private _fnc_onKillFocus = {
    params ["_ctrlEdit"];

    private _display = ctrlParent _ctrlEdit;
    private _ctrlSlider = _display displayCtrl IDC_TIMEOUT_SLIDER;

    private _value = sliderPosition _ctrlSlider;
    _ctrlEdit ctrlSetText FORMAT_ROUND(_value);
};

_ctrlEdit ctrlAddEventHandler ["KeyUp", _fnc_onKeyUp];
_ctrlEdit ctrlAddEventHandler ["KillFocus", _fnc_onKillFocus];

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _timeout = _display getVariable QGVAR(waypointTimeout);
    if (isNil "_timeout") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    _entity setWaypointTimeout [_timeout, _timeout, _timeout];
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
