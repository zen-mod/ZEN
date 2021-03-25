#include "script_component.hpp"
/*
 * Author: Ampersand
 * Draws a hint line between the given positions, with the given end point icons, for the given amount of time
 *
 * Arguments:
 * 0: Position AGL 0 <ARRAY>
 * 1: Position AGL 1 <ARRAY>
 * 2: Icon 0 <ARRAY>
 * 3: Icon 1 <ARRAY>
 * 4: Time Shown <NUMBER> in seconds
 * 5: Color <ARRAY>
 *
 * Return Value:
 * 0: _pfhID <NUMBER>
 *
 * Example:
 * [_unit, _position, 0, 1] call zen_common_fnc_drawHintLineIcon
 *
 * Public: No
 */

params [
    "_position0",
    "_position1",
    ["_icon0", [], [[]]],
    ["_icon1", [], [[]]],
    ["_color", GVAR(colorActiveElements), [[]], 4],
    ["_timeShown", 3, [0]]
];

[{
    params ["_args", "_pfhID"];
    _args params ["_timeEnd", "_position0", "_position1", "_icon0", "_icon1", "_color"];

    // Exit if selection is no longer active, remove added event handlers
    if (CBA_missionTime > _timeEnd) exitWith {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };

    drawLine3D [_position0, _position1, _color];

    if (_icon0 isNotEqualTo []) then {
        _icon0 params [
            ["_icon", ""],
            ["_text", ""],
            ["_scale", 1],
            ["_angle", 0]
        ];
        drawIcon3D [_icon, _color, _position0, _scale, _scale, _angle, _text];
    };
    if (_icon1 isNotEqualTo []) then {
        _icon1 params [
            ["_icon", ""],
            ["_text", ""],
            ["_scale", 1],
            ["_angle", 0]
        ];
        drawIcon3D [_icon, _color, _position1, _scale, _scale, _angle, _text];
    };
}, 0, [CBA_missionTime + _timeShown, _position0, _position1, _icon0, _icon1, _color]] call CBA_fnc_addPerFrameHandler
