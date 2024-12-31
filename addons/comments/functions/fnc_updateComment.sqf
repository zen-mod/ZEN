#include "script_component.hpp"
/*
 * Author: Timi007
 * Updates the comment. Must be called on server.
 *
 * Arguments:
 * 0: Unique comment id <STRING>
 * 1: Comment position ASL <ARRAY>
 * 2: Comment title <STRING>
 * 3: Comment tooltip <STRING>
 * 4: Comment color (RGBA) <ARRAY>
 * 5: Name of the curator that created the comment <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:2"] call zen_comments_fnc_updateComment
 *
 * Public: No
 */

params ["_id", "_posASL", "_title", ["_tooltip", "", [""]], ["_color", DEFAULT_COLOR, [[]], [4]], ["_creator", "", [""]]];

if (!isServer) exitWith {};

private _jipId = format [QGVAR(update_%1), _id];

TRACE_7("Update comment",_id,_posASL,_title,_tooltip,_color,_creator,_jipId);
[QGVAR(updateCommentLocal), [_id, _posASL, _title, _tooltip, _color, _creator], _jipId] call CBA_fnc_globalEventJIP;
