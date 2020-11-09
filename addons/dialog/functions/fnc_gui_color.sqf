#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the COLOR content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, [1, 0, 0, 1]] call zen_dialog_fnc_gui_color
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue"];

_defaultValue params [
    ["_r", 1, [0]],
    ["_g", 1, [0]],
    ["_b", 1, [0]],
    ["_a", 1, [0]]
];

// Need full RGBA color array to set the preview's color
private _color = [_r, _g, _b, _a];

private _ctrlPreview = _controlsGroup controlsGroupCtrl IDC_ROW_COLOR_PREVIEW;
_ctrlPreview ctrlSetBackgroundColor _color;

// Update preview when any color component's value is changed
private _fnc_updatePreview = {
    params ["", "", "_value", "_args"];
    _args params ["_ctrlPreview", "_color", "_index"];

    _color set [_index, _value];
    _ctrlPreview ctrlSetBackgroundColor _color;
};

private _controls = [];

{
    private _ctrlSlider = _controlsGroup controlsGroupCtrl (IDCS_ROW_COLOR select _forEachIndex);
    private _ctrlEdit = _controlsGroup controlsGroupCtrl (IDCS_ROW_COLOR_EDIT select _forEachIndex);

    [_ctrlSlider, _ctrlEdit, 0, 1, _x, -1, 2, false, _fnc_updatePreview, [_ctrlPreview, _color, _forEachIndex]] call EFUNC(common,initSliderEdit);

    _controls pushBack _ctrlSlider;
} forEach _defaultValue;

_controlsGroup setVariable [QGVAR(controls), _controls];

_controlsGroup setVariable [QFUNC(value), {
    params ["_controlsGroup"];

    private _controls = _controlsGroup getVariable QGVAR(controls);
    _controls apply {sliderPosition _x}
}];
