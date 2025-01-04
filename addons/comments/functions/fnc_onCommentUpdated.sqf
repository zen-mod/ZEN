#include "script_component.hpp"
/*
 * Author: Timi007
 * Updates the comment locally.
 *
 * Arguments:
 * 0: Comment id <STRING>
 * 1: Comment data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:2", [[0,0,0], "My edited Comment", "This is a nice comment", [1,0,0,0.7], "Joe"]] call zen_comments_fnc_onCommentUpdated
 *
 * Public: No
 */

params ["_id", "_data"];

GVAR(comments) set [_id, _data];

[_id] call FUNC(updateIcon);
