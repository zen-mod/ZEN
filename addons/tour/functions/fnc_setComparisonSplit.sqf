#include "script_component.hpp"
/*
 * Author: mharis001
 * Moves the divider of a comparison group.
 *
 * Arguments:
 * 0: Comparison <CONTROL>
 * 1: Split <NUMBER>
 *   - Fraction of the group's width.
 * 2: Duration <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0.5] call zen_tour_fnc_setComparisonSplit
 *
 * Public: No
 */

params ["_ctrlComparison", "_split", ["_duration", 0]];

ctrlPosition _ctrlComparison params ["", "", "_comparisonW", "_comparisonH"];
private _splitX = _comparisonW * _split;

// Sized using screen pixels to keep the handle round
private _handleW = POS_H(COMPARISON_HANDLE_SIZE) / pixelH * pixelW;
private _handleX = _splitX - _handleW / 2;
private _handleY = (_comparisonH - POS_H(COMPARISON_HANDLE_SIZE)) / 2;

{
    _x params ["_idc", "_position"];

    private _ctrl = _ctrlComparison controlsGroupCtrl _idc;
    _ctrl ctrlSetPosition _position;
    _ctrl ctrlCommit _duration;
} forEach [
    [IDC_COMPARISON_CLIP, [0, 0, _splitX, _comparisonH]],
    [IDC_COMPARISON_DIVIDER, [_splitX - pixelW, 0, 2 * pixelW, _comparisonH]],
    [IDC_COMPARISON_HANDLE, [_handleX, _handleY, _handleW, POS_H(COMPARISON_HANDLE_SIZE)]]
];
