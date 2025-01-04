#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates the comment locally.
 *
 * Arguments:
 * 0: Unique comment id <STRING>
 * 1: Comment data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:1", [[0,0,0], "My Comment", "This is a nice comment", [1,0,0,0.7], "Joe"]] call zen_comments_fnc_onCommentCreated
 *
 * Public: No
 */

params ["_id", "_data"];

GVAR(comments) set [_id, _data];

[_id, _data] call FUNC(createIcon);
