#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the `slider` attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Entity <OBJECT|GROUP|ARRAY|STRING>
 * 2: Default Value <NUMBER>
 * 3: Value Info <ARRAY>
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
 * [_controlsGroup, _entity, 0.5, [0, 1, 0.1, true]] call zen_attributes_fnc_gui_slider
 *
 * Public: No
 */

params ["_controlsGroup", "_entity", "_value", "_valueInfo"];
_valueInfo params [["_min", 0, [0]], ["_max", 1, [0]], ["_speed", 0, [0]], ["_isPercentage", false, [false]], ["_formatting", 2, [0, {}]]];

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

private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_SLIDER;
private _ctrlEdit   = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_EDIT;

_ctrlSlider sliderSetRange [_min, _max];
_ctrlSlider sliderSetSpeed [_speed, _speed];
_ctrlSlider sliderSetPosition _value;
_ctrlSlider setVariable [QGVAR(params), [_ctrlEdit, _isPercentage, _formatting, _fnc_formatValue]];

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];
    (_ctrlSlider getVariable QGVAR(params)) params ["_ctrlEdit", "_isPercentage", "_formatting", "_fnc_formatValue"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlSlider;
    _controlsGroup setVariable [QGVAR(value), _value];

    _ctrlEdit ctrlSetText call _fnc_formatValue;
}];

_ctrlEdit ctrlSetText call _fnc_formatValue;
_ctrlEdit setVariable [QGVAR(params), [_ctrlSlider, _isPercentage, _formatting, _fnc_formatValue]];

_ctrlEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_ctrlSlider", "_isPercentage"];

    private _value = parseNumber ctrlText _ctrlEdit;

    if (_isPercentage) then {
        _value = _value / 100;
    };

    private _controlsGroup = ctrlParentControlsGroup _ctrlEdit;
    _controlsGroup setVariable [QGVAR(value), _value];

    _ctrlSlider sliderSetPosition _value;
}];

_ctrlEdit ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_ctrlSlider", "_isPercentage", "_formatting", "_fnc_formatValue"];

    private _value = sliderPosition _ctrlSlider;
    _ctrlEdit ctrlSetText call _fnc_formatValue;
}];
