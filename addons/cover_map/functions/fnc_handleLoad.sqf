#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles initializing the "Cover Map" module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_cover_map_fnc_handleLoad
 *
 * Public: No
 */

params ["_display", "_logic"];

deleteVehicle _logic;

// Reposition the content controls group to make space for the map
private _ctrlContent = _display displayCtrl IDC_CONTENT;
ctrlPosition _ctrlContent params ["_contentX", "_contentY", "_contentW", "_contentH"];

_ctrlContent ctrlSetPositionY (_contentY + _contentH - POS_H(1));
_ctrlContent ctrlSetPositionH POS_H(1);
_ctrlContent ctrlCommit 0;

// Create the area label
private _ctrlLabel = _display ctrlCreate [QEGVAR(common,RscLabel), -1];
_ctrlLabel ctrlSetText localize "STR_A3_CfgVehicles_LocationArea_F_0";
_ctrlLabel ctrlSetTooltip localize LSTRING(Area_Tooltip);
_ctrlLabel ctrlSetPosition [_contentX, _contentY, _contentW, POS_H(1)];
_ctrlLabel ctrlCommit 0;

// Create the delete area button
private _ctrlDelete = _display ctrlCreate ["ctrlButtonPicture", IDC_CM_DELETE];
_ctrlDelete ctrlSetText "\a3\3den\data\cfg3den\history\deleteitems_ca.paa";
_ctrlDelete ctrlSetPosition [_contentX + _contentW - POS_W(1), _contentY, POS_W(1), POS_H(1)];
_ctrlDelete ctrlCommit 0;

_ctrlDelete ctrlAddEventHandler ["ButtonClick", {call FUNC(handleDelete)}];

// Create the map
private _ctrlMap = _display ctrlCreate [QGVAR(RscMap), IDC_CM_MAP];
_ctrlMap ctrlMapSetPosition [_contentX, _contentY + POS_H(1), _contentW, POS_H(20)];
_ctrlMap ctrlMapAnimAdd [0, 2, [worldSize / 2, worldSize / 2]];
ctrlMapAnimCommit _ctrlMap;

_ctrlMap ctrlAddEventHandler ["MouseButtonDown", {call FUNC(handleMouseButtonDown)}];
_ctrlMap ctrlAddEventHandler ["MouseButtonUp", {call FUNC(handleMouseButtonUp)}];
_ctrlMap ctrlAddEventHandler ["MouseMoving", {call FUNC(handleMouseMoving)}];
_ctrlMap ctrlAddEventHandler ["Draw", {call FUNC(handleDraw)}];

// If a cover map effect already exists, use it as the default area
private _angle = 0;

if (markerShape QGVAR(border) != "") then {
    _angle = markerDir QGVAR(border);
    _ctrlMap setVariable [QGVAR(area), [markerPos QGVAR(border), markerSize QGVAR(border), _angle]];
};

// Initialize the rotation slider and edit box
private _ctrlSlider = _display displayCtrl IDC_CM_ROTATION_SLIDER;
private _ctrlEdit = _display displayCtrl IDC_CM_ROTATION_EDIT;
[_ctrlSlider, _ctrlEdit, 0, 360, _angle, 15, EFUNC(common,formatDegrees), false, FUNC(handleRotationChanged)] call EFUNC(common,initSliderEdit);

// Confirm changes when the OK button is clicked
private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {call FUNC(handleConfirm)}];
