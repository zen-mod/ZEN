#include "script_component.hpp"
/*
 * Authors: Timi007
 * Draws a line plot in 3D or on the map. Must be called every frame.
 *
 * Arguments:
 * 0: Start position ASL <ARRAY>
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
 * [[0, 0, 0], [100, 100, 0], ["", [1, 0, 0, 1], 1, 0, 5], [{_this toFixed 0}, {_this toFixed 1}]] call zen_plotting_fnc_drawLine
 *
 * Public: No
 */

params ["_startPos", "_endPos", "_visualProperties", "_formatters", ["_ctrlMap", controlNull, [controlNull]]];
_visualProperties params ["_icon", "_color", "_scale", "_angle", "_lineWidth"];
_formatters params ["_fnc_distanceFormatter", "_fnc_azimuthFormatter"];

private _distance = _startPos vectorDistance _endPos;

private _azimuthToStart = _endPos getDir _startPos;
private _azimuthToEnd = _startPos getDir _endPos;

private _startText = format ["%1 - %2", _distance call _fnc_distanceFormatter, _azimuthToStart call _fnc_azimuthFormatter];
private _endText = format ["%1 - %2", _distance call _fnc_distanceFormatter, _azimuthToEnd call _fnc_azimuthFormatter];

if (isNull _ctrlMap) then { // 3D
    drawIcon3D [_icon, _color, ASLToAGL _startPos, _scale, _scale, _angle, _startText];
    drawLine3D [ASLToAGL _startPos, ASLToAGL _endPos, _color, _lineWidth];
    drawIcon3D [_icon, _color, ASLToAGL _endPos, _scale, _scale, _angle, _endText];
} else { // Map
    _ctrlMap drawIcon [_icon, _color, _startPos, _scale, _scale, _angle, _startText];
    _ctrlMap drawLine [_startPos, _endPos, _color];
    _ctrlMap drawIcon [_icon, _color, _endPos, _scale, _scale, _angle, _endText];
};
