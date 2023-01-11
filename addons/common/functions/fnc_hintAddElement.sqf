#include "script_component.hpp"
/*
 * Author: Ampersand
 * Draws a hint line or icon, for the given amount of time, and accepts objects as positions.
 *
 * Arguments:
 * 0: Line Params <ARRAY>
 *     Parameters of drawIcon3D or drawLine3D, but:
 *     - Accepts objects for positions
 *     - Using [] for color will draw in Active Elements game setting color ["IGUI", "TEXT_RGB"] call BIS_fnc_displayColorGet
 *     - Icon: [texture, color, position, width, height, angle, text, shadow, textSize, font, textAlign, drawSideArrows, offsetX, offsetY]
 *     - Line: [start, end, color]
 * 1: Duration <NUMBER> in seconds
 *
 * Return Value:
 * None
 *
 * Example:
 * [[_texture, [], _position, 1, 1, 0], 3] call zen_common_fnc_hintAddElement
 * [[_unit, _position, []], 3] call zen_common_fnc_hintAddElement
 *
 * Public: No
 */

params ["_elementParams", ["_duration", 3]];

_elementParams params ["_p0", "_p1", "_p2"];

if (_p0 isEqualType "") then {
    // Icon
    if (_p1 isEqualTo []) then { // Color
        _elementParams set [1, GVAR(colorActiveElements)];
    };
} else {
    // Line
    if (_p2 isEqualTo []) then { // Color
        _elementParams set [2, GVAR(colorActiveElements)];
    };
};

GVAR(hintElements) pushBack [CBA_missionTime + _duration, _elementParams];

if (GVAR(hintEHID) == -1) then {
    [] call FUNC(hintDrawElements);
};
