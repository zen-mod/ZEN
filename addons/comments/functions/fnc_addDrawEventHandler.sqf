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

GVAR(controls) = [];
{
    _x params ["_id", "_name", "_description", "_posASL"];

    private _control = _display ctrlCreate [QGVAR(RscActiveCommentIcon), -1];
    _control ctrlSetTooltip _description;

    GVAR(controls) pushBack _control;
} forEach GVAR(3DENComments);

if (!GVAR(draw3DAdded)) then {
    LOG("Adding 3DENComments Draw3D.");
    addMissionEventHandler ["Draw3D", {
        if (!GVAR(enable3DENComments)) exitWith {
            removeMissionEventHandler [_thisEvent, _thisEventHandler];

            {ctrlDelete _x} forEach GVAR(controls);

            GVAR(draw3DAdded) = false;
            LOG("Removed 3DENComments Draw3D.");
        };

        if (!(call FUNC(canDraw3DIcons))) exitWith {
            {_x ctrlShow false} forEach GVAR(controls);
        };

        [
            GVAR(3DENComments),
            GVAR(controls),
            GVAR(3DENCommentsColor),
            GVAR(3DENCommentsActiveColor)
        ] call FUNC(drawComments);
    }];

    GVAR(draw3DAdded) = true;
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

    [
        GVAR(3DENComments),
        GVAR(controls),
        GVAR(3DENCommentsColor),
        GVAR(3DENCommentsActiveColor),
        _mapCtrl
    ] call FUNC(drawComments);
}];
