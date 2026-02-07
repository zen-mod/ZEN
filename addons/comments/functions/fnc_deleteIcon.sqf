#include "script_component.hpp"
/*
 * Author: Timi007
 * Deletes the icon control of comment.
 *
 * Arguments:
 * 0: Comment id <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:2"] call zen_comments_fnc_deleteIcon
 *
 * Public: No
 */

params ["_id"];

if (_id in GVAR(icons)) then {
    ctrlDelete (GVAR(icons) deleteAt _id);
};
