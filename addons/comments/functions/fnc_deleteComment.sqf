#include "script_component.hpp"
/*
 * Author: Timi007
 * Deletes a comment.
 *
 * Arguments:
 * 0: Comment ID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0"] call zen_comments_fnc_deleteComment
 *
 * Public: No
 */

if (!isServer) exitWith {
    [QGVAR(deleteComment), _this] call CBA_fnc_serverEvent;
};

params [["_id", "", [""]]];

if !(_id in GVAR(comments)) exitWith {};

// Shares the JIP ID of the comment's created and updated events so it overwrites them
// For 3DEN comments, JIP clients will delete the comments loaded from the mission
private _jipID = format [QGVAR(%1), _id];
[QGVAR(commentDeleted), [_id], _jipID] call CBA_fnc_globalEventJIP;
TRACE_1("Comment deleted",_id);
