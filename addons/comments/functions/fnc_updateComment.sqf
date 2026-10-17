#include "script_component.hpp"
/*
 * Author: Timi007
 * Updates a comment. Only non-nil fields are changed.
 *
 * Arguments:
 * 0: Comment ID <STRING>
 * 1: Position ASL <ARRAY> (default: nil)
 * 2: Title <STRING> (default: nil)
 * 3: Tooltip <STRING> (default: nil)
 * 4: Color (RGB) <ARRAY> (default: nil)
 * 5: Creator <STRING> (default: nil)
 * 6: Lock Position <BOOL> (default: nil)
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0", [0, 0, 0], "My Updated Comment"] call zen_comments_fnc_updateComment
 *
 * Public: No
 */

if (!isServer) exitWith {
    [QGVAR(updateComment), _this] call CBA_fnc_serverEvent;
};

params [
    ["_id", "", [""]],
    ["_position", nil, [[]], 3],
    ["_title", nil, [""]],
    ["_tooltip", nil, [""]],
    ["_color", nil, [[]], 3],
    ["_creator", nil, [""]],
    ["_lockPosition", nil, [false]]
];

if !(_id in GVAR(comments)) exitWith {};

// The nil (not provided) fields are filled in with the existing values
private _oldData = GVAR(comments) get _id;
private _newData = [_position, _title, _tooltip, _color, _creator, _lockPosition];

{
    if (isNil "_x") then {
        _newData set [_forEachIndex, _oldData select _forEachIndex];
    };
} forEach _newData;

// Overwrites the comment's created event for JIP clients, they only see the latest update
private _jipID = format [QGVAR(%1), _id];
[QGVAR(commentUpdated), [_id, _newData], _jipID] call CBA_fnc_globalEventJIP;
TRACE_3("Comment updated",_id,_oldData,_newData);
