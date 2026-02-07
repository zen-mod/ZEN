#include "script_component.hpp"
/*
 * Author: Timi007
 * Move a comment.
 *
 * Arguments:
 * 0: Comment id <STRING>
 * 1: New position ASL <ARRAY>
 * 2: Move only locally <BOOLEAN> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0", [0, 0, 0], true] call zen_comments_fnc_moveComment
 *
 * Public: No
 */

params [
    ["_id", "", [""]],
    ["_position", [0, 0, 0], [[]], 3],
    ["_local", false, [false]]
];

private _data = GVAR(comments) getOrDefault [_id, []];
if (_data isEqualTo []) exitWith {};
_data set [0, _position];

if (_local) then {
    [QGVAR(commentUpdated), [_id, _data]] call CBA_fnc_localEvent;
} else {
    [QGVAR(updateComment), [_id] + _data] call CBA_fnc_serverEvent;
};
