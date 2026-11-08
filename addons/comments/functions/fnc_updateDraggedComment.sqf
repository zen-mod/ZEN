#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates the position of the comment being dragged based on the current mouse position.
 *
 * Dragging starts once the icon and the mouse separate, either from the mouse or the camera moving.
 * The comment is placed under the mouse keeping its height above the surface (terrain or sea),
 * objects are ignored. Moving the camera up or down raises or lowers it along with the camera, down to the
 * surface.
 *
 * Where no position at its height is under the mouse (e.g., aimed at the sky), it stays under the mouse
 * at the distance from the camera it had when that began, so it moves along with the camera until it can
 * keep its height again.
 *
 * Holding the Zeus raise modifier (ALT by default) moves it vertically instead.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_comments_fnc_updateDraggedComment
 *
 * Public: No
 */

// Distance in grid units the icon and the mouse need to separate before dragging starts
// Prevents clicks from moving the comment
#define DRAG_THRESHOLD 0.5

// Vertical movement is skipped when the mouse ray is close to parallel with the movement plane
#define MIN_VERTICAL_PLANE_DOT 0.05

// Prevents the comment from reaching the camera when it is kept at its distance from it
#define MIN_FALLBACK_DISTANCE 1

private _ctrlIcon = GVAR(icons) get GVAR(draggedComment);
private _data = GVAR(comments) get GVAR(draggedComment);
private _commentPos = _data select DATA_INDEX_POSITION;

// The mouse is over a different place after switching between the map and 3D, cancel instead of moving there
private _isDraggingOnMap = _ctrlIcon getVariable QGVAR(dragOnMap);

if (_isDraggingOnMap isNotEqualTo visibleMap) exitWith {
    [] call FUNC(stopDragging);
};

// Vertical camera movement raises or lowers the comment along with it, it stays on or above the surface
// The camera's height above the surface is used since the camera keeps it while flying over hills
private _cameraPos = getPosASL curatorCamera;
private _cameraHeight = (_cameraPos select 2) - (0 max getTerrainHeightASL _cameraPos);
private _previousCommentHeight = _ctrlIcon getVariable QGVAR(dragHeight);
private _previousCameraHeight = _ctrlIcon getVariable QGVAR(dragCameraHeight);
private _heightChange = _cameraHeight - _previousCameraHeight;
private _commentHeight = 0 max (_previousCommentHeight + _heightChange);
_ctrlIcon setVariable [QGVAR(dragHeight), _commentHeight];
_ctrlIcon setVariable [QGVAR(dragCameraHeight), _cameraHeight];

// Check if the mouse has moved more than the required threshold to start dragging
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
private _dragStarted = _ctrlIcon getVariable QGVAR(dragStarted);
private _mousePos = getMousePosition;

if (!_dragStarted) then {
    private _screenPos = if (visibleMap) then {
        _ctrlMap ctrlMapWorldToScreen _commentPos
    } else {
        worldToScreen ASLToAGL _commentPos
    };

    // Off screen counts as separated (i.e., the camera moved away from the comment)
    // The offset is measured in grid units so the threshold is the same pixel distance in every direction
    // Screen units are not necessarily square since the screen is not
    _dragStarted = _screenPos isEqualTo [] || {
        private _startOffset = _ctrlIcon getVariable QGVAR(dragStartOffset);
        (_screenPos vectorDiff _mousePos vectorDiff _startOffset) params ["_offsetX", "_offsetY"];
        sqrt ((_offsetX / POS_W(1)) ^ 2 + (_offsetY / POS_H(1)) ^ 2) >= DRAG_THRESHOLD
    };

    _ctrlIcon setVariable [QGVAR(dragStarted), _dragStarted];
};

if (!_dragStarted) exitWith {};

private _updatedPos = if (visibleMap) then {
    // Dragging on the map is simple
    // Get the world position and adjust for the terrain and comment height
    private _mapPos = _ctrlMap ctrlMapScreenToWorld _mousePos;
    _mapPos params ["_mapPosX", "_mapPosY"];

    [
        _mapPosX,
        _mapPosY,
        (0 max getTerrainHeightASL _mapPos) + _commentHeight
    ]
} else {
    private _rayDir = screenToWorldDirection _mousePos;

    // Move along the vertical plane through the comment that faces the camera,
    // which takes it off the mouse ray
    if (inputAction "CuratorMoveY" > 0) exitWith {
        _ctrlIcon setVariable [QGVAR(dragFallbackDistance), nil];

        private _planeNormal = _cameraPos vectorDiff _commentPos;
        _planeNormal set [2, 0];
        _planeNormal = vectorNormalized _planeNormal;

        // Kept in place when the mouse ray does not hit the plane
        if (abs (_rayDir vectorDotProduct _planeNormal) < MIN_VERTICAL_PLANE_DOT) exitWith {_commentPos};

        private _planePos = [_mousePos, _commentPos, _planeNormal] call EFUNC(common,getPosFromScreenOnPlane);
        if (_planePos isEqualTo []) exitWith {_commentPos};

        private _surfaceHeight = 0 max getTerrainHeightASL _commentPos;
        private _posZ = (_planePos select 2) max _surfaceHeight;
        _ctrlIcon setVariable [QGVAR(dragHeight), _posZ - _surfaceHeight];

        _commentPos params ["_commentPosX", "_commentPosY"];
        [_commentPosX, _commentPosY, _posZ]
    };

    private _posAtHeight = [_mousePos, _commentHeight, _commentPos] call EFUNC(common,getPosFromScreenAtHeight);

    if (_posAtHeight isNotEqualTo []) exitWith {
        _ctrlIcon setVariable [QGVAR(dragFallbackDistance), nil];
        _posAtHeight
    };

    // The comment keeps the distance from the camera it had when the mouse ray stopped passing its height,
    // so it stays under the mouse without being pulled in or pushed out as the camera moves,
    // but never behind the terrain
    private _fallbackDistance = _ctrlIcon getVariable QGVAR(dragFallbackDistance);

    if (isNil "_fallbackDistance") then {
        private _currentDistance = _commentPos vectorDiff _cameraPos vectorDotProduct _rayDir;
        _fallbackDistance = _currentDistance max MIN_FALLBACK_DISTANCE;
        _ctrlIcon setVariable [QGVAR(dragFallbackDistance), _fallbackDistance];
    };

    private _rayPos = _cameraPos vectorAdd (_rayDir vectorMultiply _fallbackDistance);
    private _terrainPos = terrainIntersectAtASL [_cameraPos, _rayPos];

    if (_terrainPos isNotEqualTo [0, 0, 0]) then {
        _rayPos = _terrainPos;
    };

    // The terrain cast does not always stop at the sea's surface
    _rayPos params ["_rayPosX", "_rayPosY", "_rayPosZ"];

    [
        _rayPosX,
        _rayPosY,
        _rayPosZ max (0 max getTerrainHeightASL _rayPos)
    ]
};

_data set [DATA_INDEX_POSITION, _updatedPos];
