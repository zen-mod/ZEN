#include "script_component.hpp"
/*
 * Author: Timi007
 * Updates the comment.
 *
 * Arguments:
 * 0: Unique comment id <STRING>
 * 1: Position ASL <ARRAY>
 * 2: Title <STRING>
 * 3: Tooltip <STRING>
 * 4: Comment color (RGBA) <ARRAY>
 * 4: Creator <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:2", [0, 0, 0], "My updated Comment", "This is a nice comment", [1, 0, 0, 0.7], "Joe"] call zen_comments_fnc_updateComment
 *
 * Public: No
 */

if (!isServer) exitWith {
    [QGVAR(updateComment), _this] call CBA_fnc_serverEvent;
};

params [
    ["_id", "", [""]],
    ["_position", [0, 0, 0], [[]], 3],
    ["_title", "", [""]],
    ["_tooltip", "", [""]],
    ["_color", DEFAULT_COLOR, [[]], 4],
    ["_creator", "", [""]]
];

private _jipId = format [QGVAR(update_%1), _id];
private _data = [_position, _title, _tooltip, _color, _creator];
[QGVAR(commentUpdated), [_id, _data], _jipId] call CBA_fnc_globalEventJIP;
TRACE_2("Comment updated",_id,_data);
