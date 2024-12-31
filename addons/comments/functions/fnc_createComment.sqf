#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates a new comment in Zeus.
 *
 * Arguments:
 * 0: Position ASL <ARRAY>
 * 1: Title <STRING>
 * 2: Tooltip <STRING> (default: "")
 * 3: Creator <STRING> (default: "")
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0], "My Comment", "This is a nice comment", "Joe"] call zen_comments_fnc_createComment
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
    ["_creator", "", [""]]
];

private _id = format ["zeus:%1", GVAR(nextID)];
private _data = [_position, _title, _tooltip, _creator];
GVAR(nextID) = GVAR(nextID) + 1;

private _jipID = format [QGVAR(%1), _id];
[QGVAR(commentCreated), [_id, _data], _jipID] call CBA_fnc_globalEventJIP;
TRACE_2("Comment created",_id,_data);
