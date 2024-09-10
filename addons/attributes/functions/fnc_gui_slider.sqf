#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "slider" attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <NUMBER>
 * 2: Value Info <ARRAY>
 *   0: Minimum Value <NUMBER>
 *   1: Maximum Value <NUMBER>
 *   2: Slider Speed <NUMBER>
 *   3: Is Percentage <BOOL>
 *   4: Formatting <NUMBER|CODE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_controlsGroup, _defaultValue, _valueInfo] call zen_attributes_fnc_gui_slider
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue", "_valueInfo"];
_valueInfo params [["_min", 0, [0]], ["_max", 1, [0]], ["_speed", -1, [0]], ["_isPercentage", false, [false]], ["_formatting", 2, [0, {}]]];

private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_SLIDER;
private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_EDIT;

private _fnc_valueChanged = {
    params ["_ctrlSlider", "", "_value"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlSlider;
    _controlsGroup setVariable [QGVAR(value), _value];
};

[_ctrlSlider, _ctrlEdit, _min, _max, _defaultValue, _speed, _formatting, _isPercentage, _fnc_valueChanged] call EFUNC(common,initSliderEdit);
