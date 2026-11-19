#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets how far a picture is zoomed and how strongly the area around its focus area is dimmed.
 *
 * Arguments:
 * 0: Picture <CONTROL>
 * 1: Zoom <NUMBER>
 *   - Fraction of the way from showing the picture in full to being fully zoomed.
 * 2: Highlight <NUMBER>
 *   - Fraction of the strength of the dims.
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 1, 1] call zen_tour_fnc_setPictureFocus
 *
 * Public: No
 */

params ["_ctrlPicture", "_zoom", "_highlight"];

_ctrlPicture getVariable QGVAR(frames) params ["_fullFrame", "_zoomedFrame"];

private _frame = [0, 1, 2, 3] apply {
    linearConversion [0, 1, _zoom, _fullFrame select _x, _zoomedFrame select _x]
};

private _ctrlImage = _ctrlPicture controlsGroupCtrl IDC_PICTURE_IMAGE;
_ctrlImage ctrlSetPosition _frame;
_ctrlImage ctrlCommit 0;

if !(_ctrlPicture getVariable QGVAR(highlight)) exitWith {};

// Dims surround the focus area, following it as the picture zooms
ctrlPosition _ctrlPicture params ["", "", "_pictureW", "_pictureH"];
_frame params ["_frameX", "_frameY", "_frameW", "_frameH"];
_ctrlPicture getVariable QGVAR(focus) params ["_focusX", "_focusY", "_focusW", "_focusH"];

private _areaX = _frameX + _focusX * _frameW;
private _areaY = _frameY + _focusY * _frameH;
private _areaW = _focusW * _frameW;
private _areaH = _focusH * _frameH;

{
    _x params ["_idc", "_position"];

    private _ctrlDim = _ctrlPicture controlsGroupCtrl _idc;
    _ctrlDim ctrlSetPosition _position;
    _ctrlDim ctrlSetFade (1 - _highlight);
    _ctrlDim ctrlCommit 0;
} forEach [
    [
        IDC_PICTURE_DIM_TOP,
        [0, 0, _pictureW, _areaY max 0]
    ],
    [
        IDC_PICTURE_DIM_BOTTOM,
        [0, _areaY + _areaH, _pictureW, (_pictureH - _areaY - _areaH) max 0]
    ],
    [
        IDC_PICTURE_DIM_LEFT,
        [0, _areaY, _areaX max 0, _areaH]
    ],
    [
        IDC_PICTURE_DIM_RIGHT,
        [_areaX + _areaW, _areaY, (_pictureW - _areaX - _areaW) max 0, _areaH]
    ],
];
