#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles a comment being created.
 *
 * Arguments:
 * 0: Comment ID <STRING>
 * 1: Comment Data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0", _data] call zen_comments_fnc_handleCommentCreated
 *
 * Public: No
 */

params ["_id", "_data"];

GVAR(comments) set [_id, _data];

[_id] call FUNC(createIcon);
