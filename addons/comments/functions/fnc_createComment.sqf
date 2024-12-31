#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates the comment. Must be called on server.
 *
 * Arguments:
 * 0: Comment position ASL <ARRAY>
 * 1: Comment title <STRING>
 * 2: Comment tooltip <STRING>
 * 3: Comment color (RGBA) <ARRAY>
 * 4: Name of the curator that created the comment <STRING>
 *
 * Return Value:
 * Id of the created comment <STRING>.
 *
 * Example:
 * [[0,0,0], "My Comment", "This is a nice comment", [1,0,0,0.7], "Joe"] call zen_comments_fnc_createComment
 *
 * Public: No
 */

params ["_posASL", "_title", ["_tooltip", "", [""]], ["_color", DEFAULT_COLOR, [[]], [4]], ["_creator", "", [""]]];

if (!isServer) exitWith {};

GVAR(nextID) = GVAR(nextID) + 1;

private _id = format ["%1:%2", COMMENT_TYPE_ZEUS, GVAR(nextID)];
private _jipId = format [QGVAR(%1), _id];

TRACE_7("Create comment",_id,_posASL,_title,_tooltip,_color,_creator,_jipId);
[QGVAR(createCommentLocal), [_id, _posASL, _title, _tooltip, _color, _creator], _jipId] call CBA_fnc_globalEventJIP;

_id
