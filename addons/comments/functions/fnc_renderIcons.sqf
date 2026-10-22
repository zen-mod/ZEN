#include "script_component.hpp"
/*
 * Author: Timi007, mharis001
 * Renders the comment icons every frame, both in 3D and on the map if it is open.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_comments_fnc_renderIcons
 *
 * Public: No
 */

BEGIN_COUNTER(renderIcons);

// Don't render anything while a dialog or the pause menu is open or in screenshot mode
if (
    dialog
    || {!isNull findDisplay IDD_INTERRUPT}
    || EFUNC(common,isInScreenshotMode)
) exitWith {
    // Stop any ongoing drag because the mouse button up event will not trigger while something else is open
    [] call FUNC(stopDragging);

    // Hide all the icons and the mouse control
    {
        _y ctrlShow false;
    } forEach GVAR(icons);

    [""] call FUNC(updateMouse);

    END_COUNTER(renderIcons);
};

// Update the dragged comment if needed
if (GVAR(draggedComment) != "") then {
    [] call FUNC(updateDraggedComment);
};

// Draw3D keeps firing while the map is open and sees the map as it is drawn in the same frame
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
private _visibleMap = visibleMap;
private _scale = [ICON_SCALE, ICON_SCALE_MAP] select _visibleMap;
private _imageW = POS_W(ICON_SIZE * _scale);
private _imageH = POS_H(ICON_SIZE * _scale);
private _cameraPos = getPosASLVisual curatorCamera;
getMousePosition params ["_mouseX", "_mouseY"];

// worldToScreen can return a non-empty position even if the position is not on screen
// This generally happens when the position is just in front of the camera but just out of view
private _screenLeftEdge = safeZoneXAbs;
private _screenRightEdge = safeZoneXAbs + safeZoneWAbs;
private _screenTopEdge = safeZoneY;
private _screenBottomEdge = safeZoneY + safeZoneH;

// The mouse control is moved over the icon of the comment under the cursor
private _mouseUpdateArgs = ["", []];

{
    private _commentPos = GVAR(comments) get _x select DATA_INDEX_POSITION;
    private _isDraggedComment = _x == GVAR(draggedComment);

    // Get the screen position based on whether the map is shown
    private _screenPos = if (_visibleMap) then {
        _ctrlMap ctrlMapWorldToScreen _commentPos
    } else {
        worldToScreen ASLToAGL _commentPos
    };

    _screenPos params ["_screenPosX", "_screenPosY"];

    // The icon is shown if its position is displayed on screen and within the render distance
    // The dragged comment is always shown and map rendering ignores the render distance
    private _show = _screenPos isNotEqualTo [] && {
        _screenPosX >= _screenLeftEdge
        && {_screenPosX <= _screenRightEdge}
        && {_screenPosY >= _screenTopEdge}
        && {_screenPosY <= _screenBottomEdge}
        && {
            _isDraggedComment
            || {_visibleMap}
            || {_commentPos vectorDistance _cameraPos <= MAX_RENDER_DISTANCE}
        }
    };

    _y ctrlShow _show;

    if (!_show) then {
        continue;
    };

    [_y, _screenPos, _scale] call FUNC(updateIconPosition);

    // When multiple comments overlap under the cursor the last one found is hovered
    // The dragged comment always keeps the mouse control so it follows the comment and the drag
    // can end anywhere, even over the interface
    private _imageX = _screenPosX - _imageW / 2;
    private _imageY = _screenPosY - _imageH / 2;

    if (
        _isDraggedComment
        || {
            GVAR(draggedComment) == ""
            && {_mouseX >= _imageX}
            && {_mouseX <= _imageX + _imageW}
            && {_mouseY >= _imageY}
            && {_mouseY <= _imageY + _imageH}
        }
    ) then {
        _mouseUpdateArgs = [_x, [_imageX, _imageY, _imageW, _imageH]];
    };

    if (_visibleMap) then {
        continue;
    };

    // Draw a line to the surface below when its height is above the threshold
    _commentPos params ["_commentPosX", "_commentPosY", "_commentPosZ"];

    private _surfaceHeight = 0 max getTerrainHeightASL _commentPos;
    private _surfacePos = [_commentPosX, _commentPosY, _surfaceHeight];

    if (_commentPosZ - _surfaceHeight >= MIN_LINE_HEIGHT) then {
        drawLine3D [
            ASLToAGL _commentPos,
            ASLToAGL _surfacePos,
            _y getVariable QGVAR(color)
        ];
    };
} forEach GVAR(icons);

_mouseUpdateArgs call FUNC(updateMouse);

END_COUNTER(renderIcons);
