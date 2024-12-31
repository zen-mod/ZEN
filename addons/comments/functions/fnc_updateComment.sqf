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
 * [[0, 0, 0], "My Comment", "This is a nice comment", "Joe"] call zen_comments_fnc_updateComment
 *
 * Public: No
 */

if (!isServer) exitWith {
    [QGVAR(updateComment), _this] call CBA_fnc_serverEvent;
};

params [
    ["_id", "", [""]],
];

// todo
