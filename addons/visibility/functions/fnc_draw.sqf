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

if (
    call EFUNC(common,isInScreenshotMode)
    || {GVAR(enabled) == INDICATOR_PLACEMENT_ONLY && {!call EFUNC(common,isPlacementActive)}}
) exitWith {};

// Get the cursor's position in the world
// Check 1.5 m above the position to check for small terrain objects blocking the view
// Converting to AGL here to avoid repeated conversions in the loop
private _pos = [] call EFUNC(common,getPosFromScreen);
private _posHigh = _pos vectorAdd [0, 0, 1.5];
private _posAGL = ASLToAGL _pos;

private _visible = false;

{
    // Check if the cursor's position is in the player's view (filter the local player and virtual units)
    if (
        _x != player
        && {side _x != sideLogic}
        && {_x distance _posAGL <= GVAR(maxDistance)}
        && {
            private _dir = _x getRelDir _pos;
            _dir <= 90 || {_dir >= 270}
        }
    ) then {
        private _eyePos = eyePos _x;

        if (
            lineIntersectsSurfaces [_eyePos, _pos, _x] isEqualTo []
            || {lineIntersectsSurfaces [_eyePos, _posHigh, _x] isEqualTo []}
        ) then {
            // Check visibility through smoke
            private _visibility = [objNull, "VIEW"] checkVisibility [_eyePos, _posHigh];

            // Draw a line from each player that can see the cursor
            drawLine3D [ASLToAGL _eyePos, _posAGL, [1, 0, 0, _visibility]];

            _visible = true;
        };
    };
} forEach allPlayers;

// Write visible under the cursor if a player can see the position
if (_visible) then {
    drawIcon3D ["", [1, 0, 0, 1], _posAGL, 1, 1.3, 0, LLSTRING(Visible), 2, 0.04, "PuristaMedium", "center"];
};
