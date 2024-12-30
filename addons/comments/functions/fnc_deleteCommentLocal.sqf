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
 * [_id] call zen_comments_fnc_deleteCommentLocal
 *
 * Public: No
 */

params ["_id"];

if (!hasInterface) exitWith {};

private _index = GVAR(comments) findIf {(_x select 0) isEqualTo _id};
if (_index < 0) exitWith {};

GVAR(comments) deleteAt _index;

[_id] call FUNC(deleteIcon);
