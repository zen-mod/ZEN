#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates a new comment.
 *
 * Arguments:
 * 0: Position ASL <ARRAY>
 * 1: Title <STRING> (default: "")
 * 2: Tooltip <STRING> (default: "")
 * 3: Color (RGB) <ARRAY> (default: based on setting)
 * 4: Creator <STRING> (default: "")
 * 5: Lock Position <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0], "My Comment"] call zen_comments_fnc_createComment
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
    ["_color", GVAR(colorDefault), [[]], 3],
    ["_creator", "", [""]],
    ["_lockPosition", false, [false]]
];

private _id = format ["%1:%2", COMMENT_TYPE_ZEUS, GVAR(nextID)];
private _data = [_position, _title, _tooltip, _color, _creator, _lockPosition];
GVAR(nextID) = GVAR(nextID) + 1;

// The comment's events share a JIP ID so only the latest one is kept for JIP players
private _jipID = format [QGVAR(%1), _id];
[QGVAR(commentCreated), [_id, _data], _jipID] call CBA_fnc_globalEventJIP;
TRACE_2("Comment created",_id,_data);
