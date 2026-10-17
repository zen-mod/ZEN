#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles a comment being deleted.
 *
 * Arguments:
 * 0: Comment ID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0"] call zen_comments_fnc_handleCommentDeleted
 *
 * Public: No
 */

params ["_id"];

[_id] call FUNC(deleteIcon);

GVAR(comments) deleteAt _id;
