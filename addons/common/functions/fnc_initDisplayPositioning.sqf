#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the given display by adjusting the positioning of controls based on the content height.
 * Requires that the display uses the common base display classes (or has a similar format).
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Has Scrollbars <BOOL> (default: false)
 * 2: Max Height <BOOL> (default: 0.9 * safeZoneH)
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_common_fnc_initDisplayPositioning
 *
 * Public: No
 */

params ["_display", ["_hasScrollbars", false], ["_maxHeight", 0.9 * safeZoneH]];

private _ctrlContent = _display displayCtrl IDC_CONTENT;

// Get the content control's position to adjust other display elements around
ctrlPosition _ctrlContent params ["_posX", "", "_posW", "_posH"];

if (_posH > _maxHeight) then {
    _posH = _maxHeight;

    // Increase width of the content control to prevent overlap between scrollbar and controls
    if (_hasScrollbars) then {
        _ctrlContent ctrlSetPositionX (_posX - POS_W(0.25));
        _ctrlContent ctrlSetPositionW (_posW + POS_W(0.5));
    };
};

_ctrlContent ctrlSetPositionY (0.5 - _posH / 2);
_ctrlContent ctrlCommit 0;

private _ctrlTitle = _display displayCtrl IDC_TITLE;
_ctrlTitle ctrlSetPositionY (0.5 - _posH / 2 - POS_H(1.6));
_ctrlTitle ctrlCommit 0;

private _ctrlBackground = _display displayCtrl IDC_BACKGROUND;
_ctrlBackground ctrlSetPositionY (0.5 - _posH / 2 - POS_H(0.5));
_ctrlBackground ctrlSetPositionH (_posH + POS_H(1));
_ctrlBackground ctrlCommit 0;

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlSetPositionY (0.5 + _posH / 2 + POS_H(0.6));
_ctrlButtonOK ctrlCommit 0;

private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;
_ctrlButtonCancel ctrlSetPositionY (0.5 + _posH / 2 + POS_H(0.6));
_ctrlButtonCancel ctrlCommit 0;
