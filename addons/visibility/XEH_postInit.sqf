#include "script_component.hpp"

["ZEN_displayCuratorLoad", {
    params ["_display"];
    GVAR(visibilityDraw) = addMissionEventHandler ["Draw3D", {
        // The the cursor position in the world
        private _pos = AGLtoASL screenToWorld getMousePosition;
        private _intersections = lineIntersectsSurfaces [getPosASL curatorCamera, _pos];
        if ((count _intersections) != 0) then {
            _pos = ((_intersections select 0) select 0);
        };

        // check 1.5 above the cursor to prevent a small object on the terrain blocking the view
        private _posHigh = [_pos select 0, _pos select 1, (_pos select 2) + 1.5];
        private _draw = false;
        {
            if (side _x != sideLogic) then {
                private _dir = (_x getRelDir _posHigh) + 90;
                if (_dir >= 360) then {
                    _dir = _dir - 360;
                };
                if (_dir < 180) then {
                    if (count lineIntersectsSurfaces [eyePos _x, _pos, _x, objNull] == 0 || {count lineIntersectsSurfaces [eyePos _x, _posHigh, _x, objNull] == 0}) then {
                        // Check visibility through smoke
                        private _visibility = [objNull, "VIEW"] checkVisibility [eyePos _x, _posHigh];
                        // Draw a line from each player that can see the cursor
                        drawLine3D [ASLToAGL eyePos _x, ASLToAGL _pos, [1, 0, 0, _visibility]];
                        _draw = true;
                    };
                };
            };
        } forEach allPlayers;

        // Write visibile under the cursor if any player can see the position
        if (_draw) then {
            drawIcon3D [
                "",
                [1, 0, 0, 1],
                ASLToAGL _pos,
                1, 3, 0,
                "VISIBLE",
                2,
                0.04,
                "PuristaMedium",
                "center"
            ];
        };
    }];
}] call CBA_fnc_addEventHandler;
