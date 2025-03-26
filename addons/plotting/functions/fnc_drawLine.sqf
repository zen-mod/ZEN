#include "script_component.hpp"
/*
 * Authors: Timi007
 * Draws a line plot in 3D or on the map. Must be called every frame.
 *
 * Arguments:
 * 0: Start position ASL or attached object <ARRAY or OBJECT>
 * 1: End position ASL or attached object <ARRAY or OBJECT>
 * 2: Visual properties <ARRAY>
 *      0: Icon <STRING>
 *      1: Color RGBA <ARRAY>
 *      2: Scale <NUMBER>
 *      3: Angle <NUMBER>
 *      4: Line width <NUMBER>
 * 3: Formatters <ARRAY>
 *      0: Distance formatter <CODE>
 *      1: Travel time formatter <CODE>
 *      2: Azimuth formatter <CODE>
 * 4: Additional arguments <ARRAY> (default: [])
 * 5: Map control <CONTROL> (default: Draw in 3D)
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0], [100, 100, 0], ["", [1, 0, 0, 1], 1, 0, 5], [{_this toFixed 0}, {[_this, 3.333] call FUNC(formatTravelTime)}, {_this toFixed 1}]] call zen_plotting_fnc_drawLine
 *
 * Public: No
 */

params ["_startPosOrObj", "_endPosOrObj", "_visualProperties", "_formatters", ["_args", [], [[]]], ["_ctrlMap", controlNull, [controlNull]]];
_visualProperties params ["_icon", "_color", "_scale", "_angle", "_lineWidth"];
_args params ["_speed"];

// Don't draw start icon and line in 3D if Zeus camera is start pos
// Also don't use speed of camera
private _startPosIsNotCamera = curatorCamera isNotEqualTo _startPosOrObj;

private _startPos = _startPosOrObj;
if (_startPosOrObj isEqualType objNull) then {
    _startPos = getPosASLVisual _startPosOrObj;

    if (_startPosIsNotCamera) then {
        _speed = velocityModelSpace _startPosOrObj select 1;
    };
};

private _endPos = _endPosOrObj;
if (_endPosOrObj isEqualType objNull) then {
    _endPos = getPosASLVisual _endPosOrObj;
};

private _distance = _startPos vectorDistance _endPos;
private _azimuth = _startPos getDir _endPos;

private _fnc_format = {
    params ["_distance", "_speed", "_azimuth", "_formatters"];
    _formatters params ["_fnc_formatDistance", "_fnc_formatTime", "_fnc_formatAzimuth"];

    format ["%1 (%2) - %3",
        _distance call _fnc_formatDistance,
        [_distance, _speed] call _fnc_formatTime,
        _azimuth call _fnc_formatAzimuth
    ]
};

if (isNull _ctrlMap) then { // 3D
    private _camPos = getPosASL curatorCamera;

    if (_startPosIsNotCamera && {CAN_RENDER_ICON(_camPos,_startPos)}) then {
        drawIcon3D [_icon, _color, ASLToAGL _startPos, _scale, _scale, _angle];
    };

    if (_startPosIsNotCamera && {CAN_RENDER_LINE(_camPos,_startPos,_endPos)}) then {
        drawLine3D [ASLToAGL _startPos, ASLToAGL _endPos, _color, _lineWidth];
    };

    if (CAN_RENDER_ICON(_camPos,_endPos)) then {
        drawIcon3D [_icon, _color, ASLToAGL _endPos, _scale, _scale, _angle, [_distance, _speed, _azimuth, _formatters] call _fnc_format];
    };
} else { // Map
    _ctrlMap drawIcon [_icon, _color, _startPos, _scale, _scale, _angle];
    _ctrlMap drawLine [_startPos, _endPos, _color];
    _ctrlMap drawIcon [_icon, _color, _endPos, _scale, _scale, _angle, [_distance, _speed, _azimuth, _formatters] call _fnc_format];
};
