#include "script_component.hpp"

params ["_controlsGroup", "_entity", "_value", "_valueInfo"];
_valueInfo params ["_min", "_max", "_speed", ["_isPercentage", false]];

private _fnc_formatValue = {
    if (_isPercentage) then {
        format [localize "STR_3DEN_percentageUnit", round (_value * 100), "%"];
    } else {
        [_value, 1, _formatting] call CBA_fnc_formatNumber;
    };
};

private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_SLIDER;
private _ctrlEdit   = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_EDIT;

_ctrlSlider sliderSetRange [_min, _max];
_ctrlSlider sliderSetSpeed [_speed, _speed];
_ctrlSlider sliderSetPosition _value;
_ctrlSlider setVariable [QGVAR(params), [_ctrlEdit, _isPercentage, _fnc_formatValue]];

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];
    (_ctrlSlider getVariable QGVAR(params)) params ["_ctrlEdit", "_isPercentage", "_fnc_formatValue"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlSlider;
    _controlsGroup setVariable [QGVAR(value), _value];

    _ctrlEdit ctrlSetText call _fnc_formatValue;
}];

_ctrlEdit ctrlSetText call _fnc_formatValue;
_ctrlEdit setVariable [QGVAR(params), [_ctrlSlider,_isPercentage, _fnc_formatValue]];

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
    (_ctrlEdit getVariable QGVAR(params)) params ["_ctrlSlider", "_isPercentage", "_fnc_formatValue"];

    private _value = sliderPosition _ctrlSlider;
    _ctrlEdit ctrlSetText call _fnc_formatValue;
}];
