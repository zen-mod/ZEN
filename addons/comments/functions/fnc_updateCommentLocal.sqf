#include "script_component.hpp"
/*
 * Author: Timi007
 * Updates the comment locally.
 *
 * Arguments:
 * 0: Comment id <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:2"] call zen_comments_fnc_updateCommentLocal
 *
 * Public: No
 */

params ["_id"];

GVAR(comments) set [_id, _this select [1]];

// Will update icon and provides hook
[QGVAR(commentUpdated), _this] call CBA_fnc_localEvent;
