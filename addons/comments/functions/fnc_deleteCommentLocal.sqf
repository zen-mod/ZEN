#include "script_component.hpp"
/*
 * Author: Timi007
 * Deletes the comment locally.
 *
 * Arguments:
 * 0: Comment id <STRING>
 *
 * Return Value:
 * Success <BOOLEAN>
 *
 * Example:
 * ["zeus:2"] call zen_comments_fnc_deleteCommentLocal
 *
 * Public: No
 */

params ["_id"];

if (!hasInterface) exitWith {false};

private _collection = [GVAR(comments), GVAR(3DENComments)] select (_id call FUNC(is3DENComment));

private _index = _collection findIf {(_x select 0) isEqualTo _id};
if (_index < 0) exitWith {false};

_collection deleteAt _index;

[_id] call FUNC(deleteIcon);

true
