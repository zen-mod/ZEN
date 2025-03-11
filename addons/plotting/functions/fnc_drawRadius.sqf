#include "script_component.hpp"
/*
 * Authors: Timi007
 * Draws a radius circle plot in 3D or on the map. Must be called every frame.
 *
 * Arguments:
 * 0: Center position ASL <ARRAY>
 * 1: End position ASL <ARRAY>
 * 2: Visual properties <ARRAY>
 *      0: Icon <STRING>
 *      1: Color RGBA <ARRAY>
 *      2: Scale <NUMBER>
 *      3: Angle <NUMBER>
 *      4: Line width <NUMBER>
 * 3: Formatters <ARRAY>
 *      0: Distance formatter <CODE>
 *      1: Azimuth formatter <CODE>
 * 3: Map control <CONTROL> (default: Draw in 3D)
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0], [100, 100, 0], ["", [1, 0, 0, 1], 1, 0, 5], [{_this toFixed 0}, {_this toFixed 1}]] call zen_plotting_fnc_drawRadius
 *
 * Public: No
 */

params ["_centerPos", "_endPos", "_visualProperties", "_formatters", ["_ctrlMap", controlNull, [controlNull]]];
_visualProperties params ["_icon", "_color", "_scale", "_angle", "_lineWidth"];

private _radius = _centerPos vectorDistance _endPos;
private _azimuth = _centerPos getDir _endPos;

private _fnc_format = {
    params ["_distance", "_azimuth", "_formatters"];
    _formatters params ["_fnc_distanceFormatter", "_fnc_azimuthFormatter"];

    format ["%1 - %2", _distance call _fnc_distanceFormatter, _azimuth call _fnc_azimuthFormatter]
};

if (isNull _ctrlMap) then { // 3D
    private _camPos = getPosASL curatorCamera;

    private _centerAGL = ASLToAGL _centerPos;
    private _endPosAGL = ASLToAGL _endPos;

    if (CAN_RENDER_ICON(_camPos,_centerPos)) then {
        drawIcon3D [_icon, _color, _centerAGL, _scale, _scale, _angle];
    };

    if (_camPos vectorDistance _centerPos <= _radius + MAX_RENDER_DISTANCE) then {
        drawLine3D [_centerAGL, _endPosAGL, _color, _lineWidth];
        drawIcon3D [_icon, _color, _endPosAGL, _scale, _scale, _angle, [_radius, _azimuth, _formatters] call _fnc_format];
    };

    private _count = CIRCLE_EDGES_MIN max floor (2 * pi * _radius ^ 0.65 / CIRCLE_RESOLUTION);
    private _factor = 360 / _count;
    private _offsets = [];

    for "_i" from 0 to (_count - 1) do {
        private _phi = _i * _factor - _azimuth;
        _offsets pushBack [_radius * cos _phi, _radius * sin _phi, 0];
    };

    for "_i" from 0 to (_count - 1) do {
        private _pos1 = _centerPos vectorAdd (_offsets select _i);
        private _pos2 = _centerPos vectorAdd (_offsets select ((_i + 1) % _count));

        if (CAN_RENDER_LINE(_camPos,_pos1,_pos2)) then {
            drawLine3D [ASLToAGL _pos1, ASLToAGL _pos2, _color, _lineWidth];
        };
    };
} else { // Map
    _ctrlMap drawIcon [_icon, _color, _centerPos, _scale, _scale, _angle];
    _ctrlMap drawLine [_centerPos, _endPos, _color];
    _ctrlMap drawEllipse [_centerPos, _radius, _radius, 0, _color, ""];
    _ctrlMap drawIcon [_icon, _color, _endPos, _scale, _scale, _angle, [_radius, _azimuth, _formatters] call _fnc_format];
};
