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

if (!isServer) exitWith {
    [QGVAR(deleteComment), _this] call CBA_fnc_serverEvent;
};

params ["_id"];

// Remove the JIP ID for updated comments
private _jipIdUpdates = format [QGVAR(update_%1), _id];
[_jipIdUpdates] call CBA_fnc_removeGlobalEventJIP;

// JIP event IDs are globally unique. For 3DEN comments, there won't be a created
// event but for Zeus ones the created JIP event will be overwritten with this
// deleted event that shares the same JIP ID, meaning that we don't have to remove
// the created JIP event.
private _jipId = format [QGVAR(%1), _id];
[QGVAR(commentDeleted), [_id]] call CBA_fnc_globalEventJIP;
TRACE_1("Comment deleted",_id);
