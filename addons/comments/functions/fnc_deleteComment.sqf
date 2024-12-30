#include "script_component.hpp"
/*
 * Author: Timi007
 * Deletes a comment created in Zeus. Must be called on server.
 *
 * Arguments:
 * 0: Comment id <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * call zen_comments_fnc_deleteComment
 *
 * Public: No
 */

params ["_id"];

private _jipId = format [QGVAR(%1), _id];
[_jipId] call CBA_fnc_removeGlobalEventJIP;

[QGVAR(removeComment), [_id]] call CBA_fnc_globalEvent;
