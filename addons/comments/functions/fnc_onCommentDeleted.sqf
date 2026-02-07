#include "script_component.hpp"
/*
 * Author: Timi007
 * Deletes the comment locally.
 *
 * Arguments:
 * 0: Comment id <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:2"] call zen_comments_fnc_onCommentDeleted
 *
 * Public: No
 */

params ["_id"];

GVAR(comments) deleteAt _id;

[_id] call FUNC(deleteIcon);
