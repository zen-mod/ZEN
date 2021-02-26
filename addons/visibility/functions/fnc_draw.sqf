#include "script_component.hpp"
/*
 * Author: Brett
 * Checks and draws the visibility indicator.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_visibility_fnc_draw
 *
 * Public: No
 */

if (call EFUNC(common,isInScreenshotMode)) exitWith {};

// The cursor position in the world
private _pos = AGLtoASL screenToWorld getMousePosition;
private _intersections = lineIntersectsSurfaces [getPosASL curatorCamera, _pos];
if (_intersections isNotEqualTo []) then {
    _pos = _intersections select 0 select 0;
};

// Check 1.5 above the cursor to prevent a small object on the terrain blocking the view
private _posHigh = _pos vectorAdd [0, 0, 1.5];
private _draw = false;

{
    // Check if the cursor's position is in the player's view (filter the local player and virtual units)
    if (_x != player && {side _x != sideLogic} && {((_x getRelDir _posHigh) + 90) mod 360 < 180}) then {
        private _eyePos = eyePos _x;
        if (lineIntersectsSurfaces [_eyePos, _pos, _x, objNull] isEqualTo [] || {lineIntersectsSurfaces [_eyePos, _posHigh, _x, objNull] isEqualTo []}) then {
            // Check visibility through smoke
            private _visibility = [objNull, "VIEW"] checkVisibility [_eyePos, _posHigh];

            // Draw a line from each player that can see the cursor
            drawLine3D [ASLToAGL _eyePos, ASLToAGL _pos, [1, 0, 0, _visibility]];

            _draw = true;
        };
    };
} forEach allPlayers;

// Write visible under the cursor if any player can see the position
if (_draw) then {
    drawIcon3D [
        "",
        [1, 0, 0, 1],
        ASLToAGL _pos,
        1, 1.3, 0,
        LLSTRING(Visible),
        2,
        0.04,
        "PuristaMedium",
        "center"
    ];
};
