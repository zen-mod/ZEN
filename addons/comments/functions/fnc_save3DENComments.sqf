#include "script_component.hpp"
/*
 * Author: Timi007
 * Function called when 3DEN save event is triggered.
 * Handles saving comments into scenario space for later use.
 *
 * Arguments:
 * 0: Event that triggered this function (for debug purposes) <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * call zen_comments_fnc_save3DENComments
 *
 * Public: No
 */

params [["_event", "", [""]]];

if (!is3DEN) exitWith {};

private _comments = [];
{
    // all3DENEntities always includes this id, ignore it
    if (_x isEqualTo -999) then {continue};

    // Ignore comments with special ignore directive in the description/tooltip
    private _tooltip = (_x get3DENAttribute "description") select 0;
    if (IGNORE_3DEN_COMMENT_STRING in _tooltip) then {continue};

    private _position = (_x get3DENAttribute "position") select 0;
    private _title = (_x get3DENAttribute "name") select 0;

    // Save in hashmap format with id as key
    _comments pushBack [format ["%1:%2", COMMENT_TYPE_3DEN, _x], [_position, _title, _tooltip]];
} forEach (all3DENEntities select 7);

// This command does not work if the mission is not saved
set3DENMissionAttributes [["Scenario", QGVAR(3DENComments), _comments]];
TRACE_2("Saved 3DEN comments",_event,_comments);
