#include "script_component.hpp"
/*
 * Author: Timi007
 * Function triggered every time the Zeus/Curator display is opened.
 * Adds the draw event handlers to display 3DEN comments in 3D and on the map.
 *
 * Arguments:
 * 0: Zeus Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_display] call zen_comments_fnc_addDrawEventHandler
 *
 * Public: No
 */

params ["_display"];
TRACE_1("Zeus display opened",_display);

if (!GVAR(enable3DENComments)) exitWith {};

if (!GVAR(draw3DAdded)) then {
    LOG("Adding 3DENComments Draw3D.");
    addMissionEventHandler ["Draw3D", {
        if (!GVAR(enable3DENComments)) exitWith {
            removeMissionEventHandler [_thisEvent, _thisEventHandler];
            GVAR(draw3DAdded) = false;
            LOG("Removed 3DENComments Draw3D.");
        };

        // Not in Zeus, in pause menu or HUD is hidden
        if (
            isNull (findDisplay IDD_RSCDISPLAYCURATOR) ||
            {!isNull (findDisplay IDD_INTERRUPT)} ||
            {call EFUNC(common,isInScreenshotMode)}
        ) exitWith {};

        private _camPosASL = getPosASLVisual curatorCamera;
        private _color = GVAR(3DENCommentsColor); // Copy global var for slightly better performance

        {
            _x params ["_id", "_name", "_description", "_posASL"];

            private _d = _posASL distance _camPosASL;
            private _scale = linearConversion [300, 750, _d, 0.8, 0, true]; // 300m => 0.8, 750m => 0
            private _posAGL = ASLToAGL _posASL;

            // Don't draw icon if it's too small or outside screen
            if (_scale < 0.01 || {(curatorCamera worldToScreen _posAGL) isEqualTo []}) then {
                continue;
            };

            drawIcon3D [
                "a3\3den\Data\Cfg3DEN\Comment\texture_ca.paa",
                _color,
                _posAGL,
                _scale,             // Width
                _scale,             // Height
                0,                  // Angle
                _name,              // Text
                1,                  // Shadow
                -1,                 // Text Size
                "RobotoCondensed"   // Font
            ];

            // Draw ground-icon connection line only for icons higher than 0.5 m
            if ((_posAGL select 2) > 0.5) then {
                drawLine3D [_posAGL, [_posAGL select 0, _posAGL select 1, 0], _color];
            };
        } count GVAR(3DENComments); // Use count for slightly better performance
    }];
};

// MapDraw EH needs to be added every time the Zeus display is opened.
LOG("Adding 3DENComments map draw.");
(_display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP) ctrlAddEventHandler ["Draw", {
    params ["_mapCtrl"];

    if (!GVAR(enable3DENComments)) exitWith {
        _mapCtrl ctrlRemoveEventHandler [_thisEvent, _thisEventHandler];
        LOG("Removed 3DENComments map draw.");
    };

    // Draw is only called when map is open
    if (call EFUNC(common,isInScreenshotMode)) exitWith {}; // HUD is hidden

    private _color = GVAR(3DENCommentsColor); // Copy global var for slightly better performance

    {
        _x params ["_id", "_name", "_description", "_posASL"];

        _mapCtrl drawIcon [
            "a3\3den\Data\Cfg3DEN\Comment\texture_ca.paa",
            _color,
            _posASL,
            24,                 // Width
            24,                 // Height
            0,                  // Angle
            _name,              // Text
            1,                  // Shadow
            -1,                 // Text Size
            "RobotoCondensed"   // Font
        ];
    } count GVAR(3DENComments); // Use count for slightly better performance
}];

GVAR(draw3DAdded) = true;
