#include "script_component.hpp"
/*
 * Author: Timi007
 * Draw comments on screen. Needs to be called every frame.
 *
 * Arguments:
 * 0: Comments <ARRAY>
 * 1: Comment controls <ARRAY>
 * 2: Comment color (RGBA) <ARRAY>
 * 2: Comment color when mouse is hovered over it (RGBA) <ARRAY>
 * 2: Map control <CONTROL> (Optional, default: Draw in 3D)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_comments, _controls, [1, 0, 0, 0.7], [1, 0, 0, 1]] call zen_comments_fnc_drawComments
 *
 * Public: No
 */

params ["_comments", "_controls", "_color", "_activeColor", ["_mapCtrl", controlNull, [controlNull]]];

private _drawIn3D = isNull _mapCtrl;

private _d = 0;
private _scale = 0;
private _screenPos = [];

{
    _x params ["_id", "_name", "_description", "_posASL"];

    private _posAGL = ASLToAGL _posASL;

    if (_drawIn3D) then {
        _d = _posASL distance (getPosASLVisual curatorCamera);
        _scale = linearConversion [SCALE_DISTANCE_START, MAX_RENDER_DISTANCE, _d, ICON_SCALE, 0, true];

        _screenPos = curatorCamera worldToScreen _posAGL;
    } else {
        _scale = MAP_ICON_SCALE;

        _screenPos = _mapCtrl ctrlMapWorldToScreen _posAGL;
    };

    private _control = _controls select _forEachIndex;

    // Don't draw icon if it's too small or outside screen
    if (_scale < 0.01 || {_screenPos isEqualTo []}) then {
        _control ctrlShow false;
        continue;
    };
    _control ctrlShow true;

    _control ctrlSetTextColor _color;
    _control ctrlSetActiveColor _activeColor;

    _screenPos params ["_posX", "_posY"];
    private _posW = POS_W(_scale);
    private _posH = POS_H(_scale);

    _control ctrlSetPosition [_posX - _posW / 2, _posY - _posH / 2, _posW, _posH];
    _control ctrlCommit 0;

    private _currentColor = [_color, _activeColor] select (_control getVariable [QGVAR(isActive), false]);

    if (_drawIn3D) then {
        // Draw comment name and connection line in 3D
        private _textOffsetScale = linearConversion [SCALE_DISTANCE_START, MAX_RENDER_DISTANCE, _d, 1, MIN_TEXT_OFFSET_SCALE, true];
        private _uiScale = getResolution select 5;
        private _textOffsetY = TEXT_OFFSET_Y * _textOffsetScale * _uiScale;

        drawIcon3D [
            "",
            _currentColor,
            _posAGL,
            _scale,             // Width
            _scale,             // Height
            0,                  // Angle
            _name,              // Text
            1,                  // Shadow
            -1,                 // Text Size
            "RobotoCondensed",  // Font
            "center",           // Align
            false,              // Arrows
            0,                  // Offset X
            _textOffsetY        // Offset Y
        ];

        // Draw ground-icon connection line only for icons higher than X m
        if ((_posAGL select 2) > GROUND_ICON_CONNECTION_HEIGHT) then {
            // Hide line behind icon
            drawLine3D [_posAGL vectorAdd [0, 0, -0.05], [_posAGL select 0, _posAGL select 1, 0], _currentColor];
        };
    } else {
        // Draw comment name on map
        _mapCtrl drawIcon [
            "#(argb,8,8,3)color(0,0,0,0)",
            _currentColor,
            _posASL,
            MAP_TEXT_SCALE,     // Width
            MAP_TEXT_SCALE,     // Height
            0,                  // Angle
            _name,              // Text
            1,                  // Shadow
            -1,                 // Text Size
            "RobotoCondensed"   // Font
        ];
    };
} forEach _comments;
