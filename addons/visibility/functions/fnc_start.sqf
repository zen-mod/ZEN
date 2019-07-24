#include "script_component.hpp"
/*
 * Author: Brett
 * Starts the Draw3D eh that indicates when a player can see the curator cursor
 *
 * Example:
 * [] call zen_visibility_fnc_start
 *
 * Public: No
 */

if (GVAR(draw) != -1) exitWith {};

GVAR(draw) = addMissionEventHandler ["Draw3D", {
    // The the cursor position in the world
    private _pos = AGLtoASL screenToWorld getMousePosition;
    private _intersections = lineIntersectsSurfaces [getPosASL curatorCamera, _pos];
    if ((count _intersections) != 0) then {
        _pos = ((_intersections select 0) select 0);
    };

    // check 1.5 above the cursor to prevent a small object on the terrain blocking the view
    private _posHigh = _pos vectorAdd [0, 0, 1.5];
    private _draw = false;
    {
        if (side _x != sideLogic) then {
            private _dir = ((_x getRelDir _posHigh) + 90) mod 360;
            if (_dir < 180) then {
                private _eyePos = eyePos _x;
                if (lineIntersectsSurfaces [_eyePos, _pos, _x, objNull] isEqualTo [] || {count lineIntersectsSurfaces [_eyePos, _posHigh, _x, objNull] == 0}) then {
                    // Check visibility through smoke
                    private _visibility = [objNull, "VIEW"] checkVisibility [_eyePos, _posHigh];
                    // Draw a line from each player that can see the cursor
                    drawLine3D [ASLToAGL _eyePos, ASLToAGL _pos, [1, 0, 0, _visibility]];
                    _draw = true;
                };
            };
        };
    } forEach allPlayers;

    // Write visible under the cursor if any player can see the position
    if (_draw) then {
        drawIcon3D [
            "",
            [1, 0, 0, 1],
            ASLToAGL _pos,
            1, 3, 0,
            LLSTRING(Visible),
            2,
            0.04,
            "PuristaMedium",
            "center"
        ];
    };
}];
