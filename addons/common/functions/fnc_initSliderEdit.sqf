#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes a slider with an edit box showing its value.
 *
 * Formatting can be specified as:
 *   - NUMBER of displayed decimal places.
 *   - CODE which is passed the value (_this) and must return a STRING.
 *
 * If a non-positive speed value is provided, an appropriate speed will be calculated based on the range.
 *
 * Is percentage will make the slider and edit controls properly handle the value as a percentage.
 * The displayed value will be multiplied by 100 and formatted with a percent sign.
 * The returned value will still be within the min and max values (ideally 0 to 1).
 * This allows the user to input a percent from 0 to 100 instead of 0 to 1.
 *
 * Optionally, a "Value Changed" callback can be provided. This code will be called any time
 * the value of the slider or edit changes. It is passed the following parameters:
 *   0: Slider <CONTROL>
 *   1: Edit <CONTROL>
 *   2: Value <NUMBER>
 *
 * Arguments:
 * 0: Slider <CONTROL>
 * 1: Edit <CONTROL>
 * 2: Min <NUMBER>
 * 3: Max <NUMBER>
 * 4: Value <NUMBER>
 * 5: Speed <NUMBER> (default: -1)
 * 6: Formatting <NUMBER|CODE> (default: 0)
 * 7: Is Percentage <BOOL> (default: false)
 * 8: Value Changed <CODE> (default: {})
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, CONTROL, 0, 1, 0.5, 0.05, 0] call zen_common_fnc_initSliderEdit
 *
 * Public: No
 */

params ["_ctrlSlider", "_ctrlEdit", "_min", "_max", "_value", ["_speed", -1, [0]], ["_formatting", 0, [0, {}]], ["_isPercentage", false, [false]], ["_fnc_valueChanged", {}, [{}]]];

if (_speed <= 0) then {
    _speed = 0.05 * (_max - _min);
};

private _fnc_formatValue = {
    if (_isPercentage) then {
        format [localize "STR_3DEN_percentageUnit", round (_value * 100), "%"];
    } else {
        if (_formatting isEqualType 0) then {
            [_value, 1, _formatting] call CBA_fnc_formatNumber;
        } else {
            _value call _formatting;
        };
    };
};

_ctrlSlider sliderSetRange [_min, _max];
_ctrlSlider sliderSetSpeed [_speed, _speed];
_ctrlSlider sliderSetPosition _value;
_ctrlSlider setVariable [QGVAR(params), [_ctrlEdit, _isPercentage, _formatting, _fnc_formatValue, _fnc_valueChanged]];

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];
    (_ctrlSlider getVariable QGVAR(params)) params ["_ctrlEdit", "_isPercentage", "_formatting", "_fnc_formatValue", "_fnc_valueChanged"];

    _ctrlEdit ctrlSetText call _fnc_formatValue;
    [_ctrlSlider, _ctrlEdit, _value] call _fnc_valueChanged;
}];

_ctrlEdit ctrlSetText call _fnc_formatValue;
_ctrlEdit setVariable [QGVAR(params), [_ctrlSlider, _isPercentage, _formatting, _fnc_formatValue, _fnc_valueChanged]];

_ctrlEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_ctrlSlider", "_isPercentage", "", "", "_fnc_valueChanged"];

    private _value = parseNumber ctrlText _ctrlEdit;

    if (_isPercentage) then {
        _value = _value / 100;
    };

    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    [_ctrlSlider, _ctrlEdit, _value] call _fnc_valueChanged;
}];

_ctrlEdit ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_ctrlSlider", "_isPercentage", "_formatting", "_fnc_formatValue"];

    private _value = sliderPosition _ctrlSlider;
    _ctrlEdit ctrlSetText call _fnc_formatValue;
}];
