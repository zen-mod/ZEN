#include "script_component.hpp"
/*
 * Author: mharis001
 * Moves a picture and its dims to their unfocused or focused positions.
 *
 * Arguments:
 * 0: Picture <CONTROL>
 * 1: Focused <BOOL>
 * 2: Duration <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, true, 1] call zen_tour_fnc_setPictureFocus
 *
 * Public: No
 */

params ["_ctrlPicture", "_isFocused", ["_duration", 0]];

private _frames = _ctrlPicture getVariable QGVAR(frames);
_frames select _isFocused params ["_rect", "_dims"];

private _ctrlImage = _ctrlPicture controlsGroupCtrl IDC_PICTURE_IMAGE;
_ctrlImage ctrlSetPosition _rect;
_ctrlImage ctrlCommit _duration;

if !(_ctrlPicture getVariable QGVAR(highlight)) exitWith {};

{
    private _ctrlDim = _ctrlPicture controlsGroupCtrl _x;
    _ctrlDim ctrlSetPosition (_dims select _forEachIndex);
    _ctrlDim ctrlSetFade parseNumber !_isFocused;
    _ctrlDim ctrlCommit _duration;
} forEach [
    IDC_PICTURE_DIM_TOP,
    IDC_PICTURE_DIM_BOTTOM,
    IDC_PICTURE_DIM_LEFT,
    IDC_PICTURE_DIM_RIGHT
];
