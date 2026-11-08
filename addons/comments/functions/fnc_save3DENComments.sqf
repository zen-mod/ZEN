#include "script_component.hpp"
/*
 * Author: Timi007
 * Saves 3DEN comments into the scenario attribute.
 *
 * Arguments:
 * 0: Event <STRING> (default: "")
 *   - The event that triggered this save (for debug purposes).
 *
 * Return Value:
 * None
 *
 * Example:
 * ["onMissionSave"] call zen_comments_fnc_save3DENComments
 *
 * Public: No
 */

params [["_event", ""]];

if (!is3DEN) exitWith {};

private _comments = [];

{
    // all3DENEntities always includes this id, ignore it
    if (_x isEqualTo -999) then {continue};

    private _show = _x get3DENAttribute QGVAR(showComment) select 0;
    if (!_show) then {continue};

    private _id = format ["%1:%2", COMMENT_TYPE_3DEN, _x];
    private _position = _x get3DENAttribute "position" select 0;
    private _title = _x get3DENAttribute "name" select 0;
    private _tooltip = _x get3DENAttribute "description" select 0;

    _comments pushBack [_id, [_position, _title, _tooltip]];
} forEach (all3DENEntities select 7);

// The 3DEN event handlers that trigger this save fire after the mission was saved
// So, we have to save the mission again if the comments were changed
private _previousComments = "Scenario" get3DENMissionAttribute QGVAR(3DENComments);

if (_comments isNotEqualTo _previousComments) then {
    set3DENMissionAttributes [["Scenario", QGVAR(3DENComments), _comments]];
    do3DENAction "MissionSave";
    TRACE_2("Saved 3DEN comments",_event,_comments);
};
