#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes a picture group from the given config, showing the picture in full.
 * Prepares the animation when the config has a focus area or zoom.
 *
 * Arguments:
 * 0: Picture <CONTROL>
 * 1: Config <CONFIG>
 *
 * Return Value:
 * Animated <BOOL>
 *
 * Example:
 * [CONTROL, _config] call zen_tour_fnc_initPicture
 *
 * Public: No
 */

params ["_ctrlPicture", "_config"];

// Prevent the zoomed picture from being scrolled within its group, so the page scrolls instead
_ctrlPicture ctrlEnable false;

private _ctrlImage = _ctrlPicture controlsGroupCtrl IDC_PICTURE_IMAGE;
_ctrlImage ctrlSetText getText (_config >> "picture");

private _focus = getArray (_config >> "focus");
private _hasFocus = _focus isEqualTypeArray [0, 0, 0, 0];
private _hasZoom = isNumber (_config >> "zoom");

// Pictures with a focus area are highlighted by default
private _highlightEntry = _config >> "highlight";
private _highlight = _hasFocus && {!isNumber _highlightEntry || {getNumber _highlightEntry == 1}};

{
    private _ctrl = _ctrlPicture controlsGroupCtrl _x;
    _ctrl ctrlShow _highlight;
} forEach [
    IDC_PICTURE_DIM_TOP,
    IDC_PICTURE_DIM_BOTTOM,
    IDC_PICTURE_DIM_LEFT,
    IDC_PICTURE_DIM_RIGHT
];

ctrlPosition _ctrlPicture params ["", "", "_pictureW", "_pictureH"];
private _rect = [0, 0, _pictureW, _pictureH];
_ctrlImage ctrlSetPosition _rect;
_ctrlImage ctrlCommit 0;

if (!_hasFocus && {!_hasZoom}) exitWith {false};

// Without a focus area, the picture zooms into its center
if (!_hasFocus) then {
    _focus = [0, 0, 1, 1];
};

_focus params ["_focusX", "_focusY", "_focusW", "_focusH"];

// By default, zoom far enough for the focus area to fill most of the picture
private _scale = if (_hasZoom) then {
    getNumber (_config >> "zoom")
} else {
    (ZOOM_FOCUS_SIZE / _focusW) min (ZOOM_FOCUS_SIZE / _focusH)
};

_scale = 1 max _scale min ZOOM_MAX;

// Keep the zoomed picture centered on the focus area without uncovering the group
private _zoomedW = _pictureW * _scale;
private _zoomedH = _pictureH * _scale;

private _focusCenterX = (_focusX + _focusW / 2) * _zoomedW;
private _focusCenterY = (_focusY + _focusH / 2) * _zoomedH;

private _zoomedX = (_pictureW / 2 - _focusCenterX) min 0 max (_pictureW - _zoomedW);
private _zoomedY = (_pictureH / 2 - _focusCenterY) min 0 max (_pictureH - _zoomedH);
private _zoomedRect = [_zoomedX, _zoomedY, _zoomedW, _zoomedH];

// Returns the positions of the dims surrounding the focus area for the given picture position
private _fnc_getDims = {
    params ["_posX", "_posY", "_posW", "_posH"];

    private _areaX = _posX + _focusX * _posW;
    private _areaY = _posY + _focusY * _posH;
    private _areaW = _focusW * _posW;
    private _areaH = _focusH * _posH;

    [
        [0, 0, _pictureW, _areaY max 0],
        [0, _areaY + _areaH, _pictureW, (_pictureH - _areaY - _areaH) max 0],
        [0, _areaY, _areaX max 0, _areaH],
        [_areaX + _areaW, _areaY, (_pictureW - _areaX - _areaW) max 0, _areaH]
    ]
};

// Positions of the picture and its dims when unfocused and focused
private _frames = [_rect, _zoomedRect] apply {[_x, _x call _fnc_getDims]};

_ctrlPicture setVariable [QGVAR(type), "picture"];
_ctrlPicture setVariable [QGVAR(state), MEDIA_STATE_HIDDEN];
_ctrlPicture setVariable [QGVAR(frames), _frames];
_ctrlPicture setVariable [QGVAR(highlight), _highlight];
_ctrlPicture setVariable [QGVAR(loop), getNumber (_config >> "loop") == 1];
[_ctrlPicture, false] call FUNC(setPictureFocus);

true
