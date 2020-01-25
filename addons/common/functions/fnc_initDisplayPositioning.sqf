#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the given display by adjusting the positioning
 * of other controls based on the content height.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_common_fnc_initDisplayPositioning
 *
 * Public: No
 */

params ["_display", ["_isScrollable", false], ["_maxHeight", 0.9 * safeZoneH]];

private _ctrlContent = _display displayCtrl IDC_CONTENT;

// Get the content height to adjust other display elements around
private _height = ctrlPosition _ctrlContent select 3;

_ctrlContent ctrlSetPositionY (0.5 - _height / 2);
_ctrlContent ctrlCommit 0;

private _ctrlTitle = _display displayCtrl IDC_TITLE;
_ctrlTitle ctrlSetPositionY (0.5 - _height / 2 - POS_H(1.6));
_ctrlTitle ctrlCommit 0;

private _ctrlBackground = _display displayCtrl IDC_BACKGROUND;
_ctrlBackground ctrlSetPositionY (0.5 - _height / 2 - POS_H(0.5));
_ctrlBackground ctrlSetPositionH (_height + POS_H(1));
_ctrlBackground ctrlCommit 0;

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlSetPositionY (0.5 + _height / 2 + POS_H(0.6));
_ctrlButtonOK ctrlCommit 0;

private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;
_ctrlButtonCancel ctrlSetPositionY (0.5 + _height / 2 + POS_H(0.6));
_ctrlButtonCancel ctrlCommit 0;
