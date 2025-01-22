#include "script_component.hpp"
/*
 * Author: mharis001
 * Applies properties from the configure menu to the area marker.
 *
 * Arguments:
 * 0: Configure Menu <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_area_markers_fnc_applyProperties
 *
 * Public: No
 */

params ["_ctrlConfigure"];

private _marker = _ctrlConfigure getVariable [QGVAR(marker), ""];

private _sizeA = parseNumber ctrlText (_ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_SIZE_A);
private _sizeB = parseNumber ctrlText (_ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_SIZE_B);
_marker setMarkerSizeLocal [_sizeA, _sizeB];

private _ctrlRotationSlider = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_ROTATION_SLIDER;
private _rotation = sliderPosition _ctrlRotationSlider;
_marker setMarkerDirLocal _rotation;

private _ctrlShape = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_SHAPE;
private _shape = ["RECTANGLE", "ELLIPSE"] select lbCurSel _ctrlShape;
_marker setMarkerShapeLocal _shape;

private _ctrlBrush = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_BRUSH;
private _brush = _ctrlBrush lbData lbCurSel _ctrlBrush;
_marker setMarkerBrushLocal _brush;

private _ctrlColor = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_COLOR;
private _color = _ctrlColor lbData lbCurSel _ctrlColor;
_marker setMarkerColorLocal _color;

private _ctrlAlphaSlider = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_ALPHA_SLIDER;
private _alpha = sliderPosition _ctrlAlphaSlider;
_marker setMarkerAlpha _alpha;
