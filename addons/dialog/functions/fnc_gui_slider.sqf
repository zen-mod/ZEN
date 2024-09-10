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
_settings params ["_min", "_max", "_formatting", "_isPercentage", "_drawRadius", "_radiusCenter", "_radiusColor"];

private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_ROW_SLIDER;
private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ROW_EDIT;

if (_drawRadius) then {
    [missionNamespace, "Draw3D", {
        _thisArgs params ["_ctrlSlider", "_center", "_color"];

        if (isNull _ctrlSlider || {_center isEqualTo objNull}) exitWith {
            removeMissionEventHandler [_thisType, _thisID];
        };

        if (_center isEqualType objNull) then {
            _center = ASLToAGL getPosASLVisual _center;
        };

        private _radius = sliderPosition _ctrlSlider;
        private _count = CIRCLE_DOTS_MIN max floor (2 * pi * _radius ^ 0.65 / CIRCLE_DOTS_SPACING);
        private _factor = 360 / _count;

        for "_i" from 0 to (_count - 1) do {
            private _phi = _i * _factor;
            private _posVector = [_radius * cos _phi, _radius * sin _phi, 0];

            drawIcon3D ["\a3\ui_f\data\map\markers\military\dot_ca.paa", _color, _center vectorAdd _posVector, CIRCLE_DOTS_SCALE, CIRCLE_DOTS_SCALE, 0];
        };
    }, [_ctrlSlider, _radiusCenter, _radiusColor]] call CBA_fnc_addBISEventHandler;
};

[_ctrlSlider, _ctrlEdit, _min, _max, _defaultValue, -1, _formatting, _isPercentage] call EFUNC(common,initSliderEdit);

_controlsGroup setVariable [QFUNC(value), {
    params ["_controlsGroup"];

    sliderPosition (_controlsGroup controlsGroupCtrl IDC_ROW_SLIDER)
}];
