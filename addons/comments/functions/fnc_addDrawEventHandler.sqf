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

if (!GVAR(enableComments) && !GVAR(enable3DENComments)) exitWith {};

{
    [_display, _x] call FUNC(createIcon);
} forEach (GVAR(3DENComments) + GVAR(comments));

if (!GVAR(draw3DAdded)) then {
    LOG("Adding Draw3D.");
    addMissionEventHandler ["Draw3D", FUNC(onDraw3D)];
    GVAR(draw3DAdded) = true;
};

// MapDraw EH needs to be added every time the Zeus display is opened.
LOG("Adding map draw.");
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
_ctrlMap ctrlAddEventHandler ["Draw", FUNC(onDraw)];
