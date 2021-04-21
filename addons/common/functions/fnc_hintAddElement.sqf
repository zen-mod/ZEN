#include "script_component.hpp"
/*
 * Author: Ampersand
 * Draws a hint line or icon, for the given amount of time, and accepts objects as positions.
 *
 * Arguments:
 * 0: Time Shown <NUMBER> in seconds
 * 1: Line Params <ARRAY>
 *     Parameters of drawIcon3D or drawLine3D, but:
 *     - Accepts objects for positions
 *     - Using [] for color will draw in Active Elements game setting color ["IGUI", "TEXT_RGB"] call BIS_fnc_displayColorGet
 *     - Icon: [texture, color, position, width, height, angle, text, shadow, textSize, font, textAlign, drawSideArrows, offsetX, offsetY]
 *     - Line: [start, end, color]
 *
 * Return Value:
 * None
 *
 * Example:
 * [2, [_texture, [], _position, 1, 1, 0]] call zen_common_fnc_hintAddElement
 * [2, [_unit, _position, []]] call zen_common_fnc_hintAddElement
 *
 * Public: No
 */

params ["_time", "_elementParams"];
_elementParams params ["_p0", "_p1", "_p2"];

if (_p0 isEqualType "") then {
    // Icon
    if (_p1 isEqualTo []) then {
        _elementParams set [1, GVAR(colorActiveElements)];
    };
} else {
    // line
    if (_p2 isEqualTo []) then {
        _elementParams set [2, GVAR(colorActiveElements)];
    };
};

GVAR(hintElements) pushBack [CBA_missionTime + _time, _elementParams];

if (GVAR(hintEHID) == -1) then {
    [] call FUNC(hintDrawElements);
};
