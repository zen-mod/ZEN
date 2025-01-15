#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates a new comment in Zeus.
 *
 * Arguments:
 * 0: Position ASL <ARRAY>
 * 1: Title <STRING>
 * 2: Tooltip <STRING> (default: "")
 * 3: Comment color (RGBA) <ARRAY> (default: yellow)
 * 4: Creator <STRING> (default: "")
 * 5: Lock position <BOOLEAN> (default: false)
 *
 * Return Value:
 * Id of the created comment <STRING>.
 *
 * Example:
 * [[0, 0, 0], "My Comment", "This is a nice comment", [1, 0, 0, 0.7], "Joe", false] call zen_comments_fnc_createComment
 *
 * Public: No
 */

if (!isServer) exitWith {
    [QGVAR(createComment), _this] call CBA_fnc_serverEvent;
};

params [
    ["_position", [0, 0, 0], [[]], 3],
    ["_title", "", [""]],
    ["_tooltip", "", [""]],
    ["_color", DEFAULT_COLOR, [[]], 4],
    ["_creator", "", [""]],
    ["_lockPosition", false, [false]]
];

private _id = format ["%1:%2", COMMENT_TYPE_ZEUS, GVAR(nextID)];
private _data = [_position, _title, _tooltip, _color, _creator, _lockPosition];
GVAR(nextID) = GVAR(nextID) + 1;

private _jipId = format [QGVAR(%1), _id];
[QGVAR(commentCreated), [_id, _data], _jipId] call CBA_fnc_globalEventJIP;
TRACE_2("Comment created",_id,_data);

_id
