#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles pressing a mouse button on a comment's icon.
 *
 * Arguments:
 * 0: Mouse Control <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_comments_fnc_handleMouseButtonDown
 *
 * Public: No
 */

params ["_ctrlMouse", "_button"];

if (_button != 0 || {GVAR(hoveredComment) == ""}) exitWith {};

// Clear the selection (like clicking on any other entity in Zeus)
setCuratorSelected [];

// Exit if the comment cannot be moved
private _data = GVAR(comments) get GVAR(hoveredComment);
private _lockPosition = _data select DATA_INDEX_LOCK_POSITION;

if (_lockPosition || {GVAR(hoveredComment) call FUNC(is3DENComment)}) exitWith {};

// Get the comment's and camera's positions and their heights above the surface (terrain or sea)
private _commentPos = _data select DATA_INDEX_POSITION;
private _commentHeight = (_commentPos select 2) - (0 max getTerrainHeightASL _commentPos);

private _cameraPos = getPosASL curatorCamera;
private _cameraHeight = (_cameraPos select 2) - (0 max getTerrainHeightASL _cameraPos);

// Get the comment's position on screen based on whether the map is shown
private _screenPos = if (visibleMap) then {
    private _display = ctrlParent _ctrlMouse;
    private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    _ctrlMap ctrlMapWorldToScreen _commentPos
} else {
    worldToScreen ASLToAGL _commentPos
};

// Set up dragging state variables on the icon control
private _ctrlIcon = GVAR(icons) get GVAR(hoveredComment);
_ctrlIcon setVariable [QGVAR(dragOriginalPos), _commentPos];
_ctrlIcon setVariable [QGVAR(dragStartOffset), _screenPos vectorDiff getMousePosition];
_ctrlIcon setVariable [QGVAR(dragHeight), _commentHeight];
_ctrlIcon setVariable [QGVAR(dragCameraHeight), _cameraHeight];
_ctrlIcon setVariable [QGVAR(dragStarted), false];
_ctrlIcon setVariable [QGVAR(dragOnMap), visibleMap];
_ctrlIcon setVariable [QGVAR(dragFallbackDistance), nil];

GVAR(draggedComment) = GVAR(hoveredComment);
