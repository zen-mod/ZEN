#include "script_component.hpp"
/*
 * Author: Timi007
 * Deletes the comment. Must be called on server.
 *
 * Arguments:
 * 0: Comment id <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:2"] call zen_comments_fnc_deleteComment
 *
 * Public: No
 */

params ["_id"];

if (!isServer) exitWith {};

TRACE_1("Delete comment",_id);
if (_id call FUNC(is3DENComment)) then {
    [QGVAR(deleteCommentLocal), [_id]] call CBA_fnc_globalEventJIP;
} else {
    private _jipId = format [QGVAR(%1), _id];
    [_jipId] call CBA_fnc_removeGlobalEventJIP;

    [QGVAR(deleteCommentLocal), [_id]] call CBA_fnc_globalEvent;
};
