/*
 * Author: mharis001
 * Initializes the "Slider" Zeus module attribute.
 *
 * Arguments:
 * 0: Controls group <CONTROL>
 * 1: Value min <NUMBER>
 * 2: Value max <NUMBER>
 * 3: Default value <NUMER>
 * 4: Number of decimals <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, 10, 1] call zen_modules_fnc_ui_attributeSlider
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_controlsGroup", "_min", "_max", "_value", ["_decimals", 0]];

_controlsGroup setVariable [QGVAR(params), [_decimals]];
_controlsGroup setVariable [QGVAR(value), _value];

private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SLIDER;
_ctrlSlider sliderSetRange [_min, _max];
_ctrlSlider sliderSetPosition _value;

private _range = _max - _min;
_ctrlSlider sliderSetSpeed [_range / 20, _range / 10];

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlSlider;
    (_controlsGroup getVariable QGVAR(params)) params ["_decimals"];

    private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_EDIT;
    _ctrlEdit ctrlSetText ([_value, 1, _decimals] call CBA_fnc_formatNumber);

    _controlsGroup setVariable [QGVAR(value), _value];
}];

private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_EDIT;
_ctrlEdit ctrlSetText ([_value, 1, _decimals] call CBA_fnc_formatNumber);

_ctrlEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEdit"];

    private _value = parseNumber ctrlText _ctrlEdit;

    private _controlsGroup = ctrlParentControlsGroup _ctrlEdit;
    (_controlsGroup getVariable QGVAR(params)) params ["_decimals"];

    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SLIDER;
    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    _controlsGroup setVariable [QGVAR(value), _value];
}];

_ctrlEdit ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlEdit"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlEdit;
    (_controlsGroup getVariable QGVAR(params)) params ["_decimals"];

    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SLIDER;
    private _value = sliderPosition _ctrlSlider;

    _ctrlEdit ctrlSetText ([_value, 1, _decimals] call CBA_fnc_formatNumber);
}];
