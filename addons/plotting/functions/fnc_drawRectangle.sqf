#include "script_component.hpp"
/*
 * Authors: Timi007
 * Draws a rectangle plot in 3D or on the map.
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
    private _startPosAGL = ASLToAGL _startPos;
    private _endPosAGL = ASLToAGL _endPos;

    drawIcon3D [_icon, _color, _startPosAGL, _scale, _scale, _angle];

    private _corners = [[[_startPosAGL, _endPosAGL]] call EFUNC(common,zip)] call EFUNC(common,cartesianProduct);
    private _count = count _corners;

    for "_i" from 0 to (_count - 1) do {
        drawLine3D [_corners select _i, _corners select ((_i + 1) % _count), _color, _lineWidth];
    };

    drawIcon3D [_icon, _color, _endPosAGL, _scale, _scale, _angle, _text];
} else { // Map
    _ctrlMap drawIcon [_icon, _color, _startPos, _scale, _scale, _angle];
    private _center = (_startPos vectorAdd _endPos) vectorMultiply 0.5;
    _ctrlMap drawRectangle [_center, _a / 2, _b / 2, 0, _color, ""];
    _ctrlMap drawIcon [_icon, _color, _endPos, _scale, _scale, _angle, _text];
};
