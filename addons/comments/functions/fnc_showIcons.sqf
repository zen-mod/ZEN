#include "script_component.hpp"
/*
 * Author: Timi007
 * Shows or hides all icons of given comments.
 *
 * Arguments:
 * 0: Comments <ARRAY>
 * 1: Comment controls <HASHMAP>
 * 2: Show icons <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [GVAR(comments), GVAR(icons), false] call zen_comments_fnc_showIcons
 *
 * Public: No
 */

params ["_comments", "_icons", ["_show", true, [true]]];

{
    _x params ["_id"];

    (_icons get _id) ctrlShow _show;
} forEach _comments;
