#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates a comment in Zeus. Must be called on server.
 *
 * Arguments:
 * 0: Comment position ASL <ARRAY>
 * 1: Comment title <STRING>
 * 2: Comment tooltip <STRING>
 * 3: Name of the curator that created the comment <STRING>
 *
 * Return Value:
 * None.
 *
 * Example:
 * [[0,0,0], "My Comment", "This is a nice comment", "Joe"] call zen_comments_fnc_createComment
 *
 * Public: No
 */

params ["_posASL", "_title", ["_tooltip", "", [""]], ["_creator", "", [""]]];

if (!isServer) exitWith {};

GVAR(nextID) = GVAR(nextID) + 1;

private _id = format ["zeus:%1", GVAR(nextID)];
private _jipId = format [QGVAR(%1), _id];

TRACE_6("Create comment",_id,_posASL,_title,_tooltip,_creator,_jipId);
[QGVAR(createCommentLocal), [_id, _posASL, _title, _tooltip, _creator], _jipId] call CBA_fnc_globalEventJIP;
