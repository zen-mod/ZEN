#include "script_component.hpp"
/*
 * Authors: Timi007
 * Draws a rectangle plot in 3D or on the map. Must be called every frame.
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
 * 3: Map control <CONTROL> (default: Draw in 3D)
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0], [100, 100, 0], ["", [1, 0, 0, 1], 1, 0, 5], [{_this toFixed 0}]] call zen_plotting_fnc_drawRectangle
 *
 * Public: No
 */

params ["_startPos", "_endPos", "_visualProperties", "_formatters", ["_ctrlMap", controlNull, [controlNull]]];
_visualProperties params ["_icon", "_color", "_scale", "_angle", "_lineWidth"];
_formatters params ["_fnc_distanceFormatter"];

private _offset = _endPos vectorDiff _startPos;
_offset params ["_a", "_b", "_c"];

private _text = format ["X: %1 - Y: %2 - Z: %3", _a call _fnc_distanceFormatter, _b call _fnc_distanceFormatter, _c call _fnc_distanceFormatter];

if (isNull _ctrlMap) then { // 3D
    drawIcon3D [_icon, _color, ASLToAGL _startPos, _scale, _scale, _angle];

    _startPos params ["_x1", "_y1", "_z1"];
    _endPos params ["_x2", "_y2", "_z2"];

    private _height = abs (_z2 - _z1);

    private _edges = [];
    if (_height > CUBOID_HEIGHT_THRESHOLD) then {
        _edges = [
            [[_x1, _y1, _z1], [_x2, _y1, _z1], [_x2, _y2, _z1], [_x1, _y2, _z1], [_x1, _y1, _z1]], // Rectangle same height as start pos
            [[_x1, _y1, _z2], [_x2, _y1, _z2], [_x2, _y2, _z2], [_x1, _y2, _z2], [_x1, _y1, _z2]], // Rectangle same height as end pos
            // Connections from start to end height
            [[_x1, _y1, _z1], [_x1, _y1, _z2]],
            [[_x2, _y1, _z1], [_x2, _y1, _z2]],
            [[_x2, _y2, _z1], [_x2, _y2, _z2]],
            [[_x1, _y2, _z1], [_x1, _y2, _z2]]
        ];
    } else {
        // Don't draw cuboid if height difference is small
        _edges = [
            [[_x1, _y1, _z1], [_x2, _y1, _z1], [_x2, _y2, _z1], [_x1, _y2, _z1], [_x1, _y1, _z1]]
        ];
    };

    {
        for "_i" from 0 to (count _x - 2) do {
            drawLine3D [ASLToAGL (_x select _i), ASLToAGL (_x select (_i + 1)), _color, _lineWidth];
        };
    } forEach _edges;

    drawIcon3D [_icon, _color, ASLToAGL _endPos, _scale, _scale, _angle, _text];
} else { // Map
    _ctrlMap drawIcon [_icon, _color, _startPos, _scale, _scale, _angle];
    private _center = (_startPos vectorAdd _endPos) vectorMultiply 0.5;
    _ctrlMap drawRectangle [_center, _a / 2, _b / 2, 0, _color, ""];
    _ctrlMap drawIcon [_icon, _color, _endPos, _scale, _scale, _angle, _text];
};
