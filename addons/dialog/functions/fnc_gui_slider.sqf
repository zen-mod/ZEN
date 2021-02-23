#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the SLIDER content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <NUMBER>
 * 2: Settings <ARRAY>
 *   0: Minimum Value <NUMBER>
 *   1: Maximum Value <NUMBER>
 *   2: Formatting <NUMBER|CODE>
 *   3: Is Percentage <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 5, [0, 10, 1, false]] call zen_dialog_fnc_gui_slider
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue", "_settings"];
_settings params ["_min", "_max", "_formatting", "_isPercentage", "_radiusIndex"];

private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_ROW_SLIDER;
private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ROW_EDIT;
private _fnc_valueChanged = {};

if !(isNil "_radiusIndex") then {
    _ctrlSlider setVariable [QGVAR(radiusIndex), _radiusIndex];

    _fnc_valueChanged = {
        params ["_ctrlSlider", "", "_value"];

        private _radiusIndex = _ctrlSlider getVariable QGVAR(radiusIndex);

        GVAR(radiuses) set [_radiusIndex, _value];
    };
};

[_ctrlSlider, _ctrlEdit, _min, _max, _defaultValue, -1, _formatting, _isPercentage, _fnc_valueChanged] call EFUNC(common,initSliderEdit);

_controlsGroup setVariable [QFUNC(value), {
    params ["_controlsGroup"];

    sliderPosition (_controlsGroup controlsGroupCtrl IDC_ROW_SLIDER)
}];
