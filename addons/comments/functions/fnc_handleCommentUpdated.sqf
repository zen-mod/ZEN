#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles a comment being updated.
 *
 * Arguments:
 * 0: Comment ID <STRING>
 * 1: Comment Data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0", _data] call zen_comments_fnc_handleCommentUpdated
 *
 * Public: No
 */

params ["_id", "_data"];

// JIP players only receive the latest update of a comment, which overwrites its created event
if !(_id in GVAR(comments)) exitWith {
    [QGVAR(commentCreated), _this] call CBA_fnc_localEvent;
};

GVAR(comments) set [_id, _data];

[_id] call FUNC(updateIcon);
