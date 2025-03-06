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
 * 5: Creator <STRING>
 * 6: Lock position <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:2", [0, 0, 0], "My updated Comment", "This is a nice comment", [1, 0, 0, 0.7], "Joe", false] call zen_comments_fnc_updateComment
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
    ["_creator", "", [""]],
    ["_lockPosition", false, [false]]
];

private _data = [_position, _title, _tooltip, _color, _creator, _lockPosition];
private _jipId = format [QGVAR(%1), _id];
[QGVAR(commentUpdated), [_id, _data], _jipId] call CBA_fnc_globalEventJIP;
TRACE_2("Comment updated",_id,_data);
