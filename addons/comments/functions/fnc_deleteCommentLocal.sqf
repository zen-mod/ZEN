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
 * ["zeus:2"] call zen_comments_fnc_deleteCommentLocal
 *
 * Public: No
 */

params ["_id"];

GVAR(comments) deleteAt _id;

// Will delete icon and provides hook
[QGVAR(commentDeleted), [_id]] call CBA_fnc_localEvent;
