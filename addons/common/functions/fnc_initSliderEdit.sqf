/*
 * Author: mharis001
 * Initializes a slider with an edit box showing its value.
 *
 * Arguments:
 * 0: Slider <CONTROL>
 * 1: Edit <CONTROL>
 * 2: Min <NUMBER>
 * 3: Max <NUMBER>
 * 4: Value <NUMBER>
 * 5: Speed <NUMBER>
 * 6: Formatting <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, CONTROL, 0.5, 0, 1, 0.05, 2] call zen_common_fnc_initSliderEdit
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_ctrlSlider", "_ctrlEdit", "_value", "_min", "_max", "_speed", ["_decimals", 0, [0]], ["_formatting", "%1", [""]]];

_ctrlSlider sliderSetRange [_min, _max];
_ctrlSlider sliderSetSpeed [_speed, _speed];
_ctrlSlider sliderSetPosition _value;

_ctrlSlider setVariable [QGVAR(params), [_ctrlEdit, _decimals, _formatting]];

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];
    (_ctrlSlider getVariable QGVAR(params)) params ["_ctrlEdit", "_decimals", "_formatting"];

    private _formattedValue = format [_formatting, [_value, 1, _decimals] call CBA_fnc_formatNumber];
    _ctrlEdit ctrlSetText _formattedValue;
}];

private _formattedValue = format [_formatting, [_value, 1, _decimals] call CBA_fnc_formatNumber];
_ctrlEdit ctrlSetText _formattedValue;

_ctrlEdit setVariable [QGVAR(params), [_ctrlSlider, _decimals, _formatting]];

_ctrlEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_ctrlSlider"];

    private _value = parseNumber ctrlText _ctrlEdit;
    _ctrlSlider sliderSetPosition _value;
}];

_ctrlEdit ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_ctrlSlider", "_decimals", "_formatting"];

    private _value = sliderPosition _ctrlSlider;
    private _formattedValue = format [_formatting, [_value, 1, _decimals] call CBA_fnc_formatNumber];
    _ctrlEdit ctrlSetText _formattedValue;
}];
