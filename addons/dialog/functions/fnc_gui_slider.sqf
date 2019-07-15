/*
 * Author: mharis001
 * Initializes the SLIDER content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Row Index <NUMBER>
 * 2: Current Value <NUMBER>
 * 3: Row Settings <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, 5, [0, 10, 1]] call zen_dialog_fnc_gui_slider
 *
 * Public: No
 */
#include "script_component.hpp"

#define FORMAT_VALUE(value,formatting,isPercentage) (\
    if (isPercentage) then { \
        format ["%1%2", round (value * 100), "%"]; \
    } else { \
        if (formatting isEqualType {}) then { \
            value call formatting; \
        } else { \
            [value, 1, formatting] call CBA_fnc_formatNumber; \
        }; \
    })

params ["_controlsGroup", "_rowIndex", "_currentValue", "_rowSettings"];
_rowSettings params ["_min", "_max", "_formatting", "_isPercentage"];

private _range = _max - _min;

private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_ROW_SLIDER;
_ctrlSlider sliderSetRange [_min, _max];
_ctrlSlider sliderSetPosition _currentValue;
_ctrlSlider sliderSetSpeed [0.05 * _range, 0.1 * _range];
_ctrlSlider setVariable [QGVAR(params), [_rowIndex, _formatting, _isPercentage]];

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];
    (_ctrlSlider getVariable QGVAR(params)) params ["_rowIndex", "_formatting", "_isPercentage"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlSlider;
    private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ROW_SLIDER_EDIT;
    _ctrlEdit ctrlSetText FORMAT_VALUE(_value,_formatting,_isPercentage);

    private _display = ctrlParent _ctrlSlider;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _value];
}];

private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ROW_SLIDER_EDIT;
_ctrlEdit ctrlSetText FORMAT_VALUE(_currentValue,_formatting,_isPercentage);
_ctrlEdit setVariable [QGVAR(params), [_rowIndex, _formatting, _isPercentage]];

_ctrlEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_rowIndex", "_formatting", "_isPercentage"];

    private _value = parseNumber ctrlText _ctrlEdit;

    if (_isPercentage) then {
        _value = _value / 100; // User will enter a percent from 0-100 not 0-1
    };

    private _controlsGroup = ctrlParentControlsGroup _ctrlEdit;
    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_ROW_SLIDER;

    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    private _display = ctrlParent _ctrlEdit;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _value];
}];

_ctrlEdit ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["", "_formatting", "_isPercentage"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlEdit;
    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_ROW_SLIDER;

    private _value = sliderPosition _ctrlSlider;
    _ctrlEdit ctrlSetText FORMAT_VALUE(_value,_formatting,_isPercentage);
}];
