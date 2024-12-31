#include "script_component.hpp"
/*
 * Author: Timi007
 * Saves comments from 3DEN into the mission attributes for later use.
 *
 * Arguments:
 * 0: Event <STRING> (default: "")
 *   - The event that triggered this save, for debug purposes.
 *
 * Return Value:
 * None
 *
 * Example:
 * call zen_comments_fnc_save3DENComments
 *
 * Public: No
 */

if (!is3DEN) exitWith {};

params [["_event", "", [""]]];

private _comments = [];

{
    // all3DENEntities always includes this id, ignore it
    if (_x isEqualTo -999) then {continue};

    private _position = (_x get3DENAttribute "position") select 0;
    private _title = (_x get3DENAttribute "name") select 0;
    private _tooltip = (_x get3DENAttribute "description") select 0;

    // Ignore comments with special ignore directive in the tooltip
    if (IGNORE_3DEN_COMMENT_STRING in _tooltip) then {continue};

    _comments pushBack [format ["3den:%1", _x], _position, _title, _tooltip];
} forEach (all3DENEntities select 7);

// This command does not work if the mission is not saved
set3DENMissionAttributes [["Scenario", QGVAR(3DENComments), _comments]];

TRACE_2("Saved 3DEN comments",_event,_comments);
