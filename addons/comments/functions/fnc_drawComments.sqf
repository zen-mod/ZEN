#include "script_component.hpp"
/*
 * Author: Timi007
 * Draws comments on screen. Needs to be called every frame.
 *
 * Arguments:
 * 0: Comments <HASHMAP>
 * 1: Comment controls <HASHMAP>
 * 2: Draw Zeus comments <BOOLEAN> (Optional, default: true)
 * 3: Draw 3DEN comments <BOOLEAN> (Optional, default: true)
 * 4: Map control <CONTROL> (Optional, default: Draw in 3D)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_comments, _icons] call zen_comments_fnc_drawComments
 *
 * Public: No
 */

params ["_comments", "_icons", ["_drawZeus", true, [true]], ["_draw3DEN", true, [true]], ["_mapCtrl", controlNull, [controlNull]]];

private _drawIn3D = isNull _mapCtrl;

private _d = 0;
private _scale = 0;
private _screenPos = [];

{
    private _id = _x;
    _y params ["_posASL", "_title", "_tooltip", ["_color", []], ["_creator", ""]];

    private _ctrlIcon = _icons getOrDefault [_id, controlNull];
    if (isNull _ctrlIcon) then {
        continue;
    };

    private _is3DENComment = _creator isEqualTo ""; // Faster then calling FUNC(is3DENComment)
    if ((!_is3DENComment && !_drawZeus) || (_is3DENComment && !_draw3DEN)) then {
        _ctrlIcon ctrlShow false;
        continue;
    };

    private _posAGL = ASLToAGL _posASL;

    if (_drawIn3D) then {
        _d = _posASL distance (getPosASLVisual curatorCamera);
        _scale = linearConversion [SCALE_DISTANCE_START, MAX_RENDER_DISTANCE, _d, ICON_SCALE, 0, true];

        _screenPos = curatorCamera worldToScreen _posAGL;
    } else {
        _scale = MAP_ICON_SCALE;

        _screenPos = _mapCtrl ctrlMapWorldToScreen _posAGL;
    };

    // Don't draw icon if it's too small or outside screen
    if (_scale < 0.01 || {_screenPos isEqualTo []}) then {
        _ctrlIcon ctrlShow false;
        continue;
    };
    _ctrlIcon ctrlShow true;

    if (_color isEqualTo []) then {
        if (_is3DENComment) then {
            _color = GVAR(3DENColor);
        } else {
            _color = DEFAULT_COLOR;
        };
    };
    private _activeColor = [_color select 0, _color select 1, _color select 2, 1];

    _ctrlIcon ctrlSetTextColor _color;
    _ctrlIcon ctrlSetActiveColor _activeColor;

    _screenPos params ["_posX", "_posY"];
    private _posW = POS_W(_scale);
    private _posH = POS_H(_scale);

    _ctrlIcon ctrlSetPosition [_posX - _posW / 2, _posY - _posH / 2, _posW, _posH];
    _ctrlIcon ctrlCommit 0;

    private _currentColor = [_color, _activeColor] select (_ctrlIcon getVariable [QGVAR(isActive), false]);

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
            _title,             // Text
            1,                  // Shadow
            -1,                 // Text Size
            "RobotoCondensed",  // Font
            "center",           // Align
            false,              // Arrows
            0,                  // Offset X
            _textOffsetY        // Offset Y
        ];

        if (_creator isNotEqualTo "") then {
            drawIcon3D [
                "",
                _currentColor,
                _posAGL,
                _scale,                 // Width
                _scale,                 // Height
                0,                      // Angle
                _creator,               // Text
                1,                      // Shadow
                -1,                     // Text Size
                "RobotoCondensedBold"   // Font
            ];
        };

        // Draw ground-icon connection line only for icons higher than X m
        if ((_posAGL select 2) > GROUND_ICON_CONNECTION_HEIGHT) then {
            // Hide line behind icon
            drawLine3D [_posAGL vectorAdd [0, 0, -0.05], [_posAGL select 0, _posAGL select 1, 0], _currentColor];
        };
    } else {
        // Draw comment name on map
        private _text = if (_creator isEqualTo "") then {
            _title
        } else {
            format ["%1: %2", _creator, _title];
        };

        _mapCtrl drawIcon [
            "#(argb,8,8,3)color(0,0,0,0)",
            _currentColor,
            _posASL,
            MAP_TEXT_SCALE,     // Width
            MAP_TEXT_SCALE,     // Height
            0,                  // Angle
            _text,              // Text
            1,                  // Shadow
            -1,                 // Text Size
            "RobotoCondensed"   // Font
        ];
    };
} forEach _comments;
