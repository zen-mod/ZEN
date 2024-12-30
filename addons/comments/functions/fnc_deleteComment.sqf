#include "script_component.hpp"
/*
 * Author: Timi007
 * Deletes a comment created in Zeus. Must be called on server.
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

if !(_id call FUNC(is3DENComment)) then {
    private _jipId = format [QGVAR(%1), _id];
    [_jipId] call CBA_fnc_removeGlobalEventJIP;
};

TRACE_1("Delete comment",_id);
[QGVAR(deleteCommentLocal), [_id]] call CBA_fnc_globalEvent;
