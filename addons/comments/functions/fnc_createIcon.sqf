#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates an icon control for the comment.
 *
 * Arguments:
 * 0: Zeus display <DISPLAY>
 * 1: Comment <ARRAY>
 *
 * Return Value:
 * None.
 *
 * Example:
 * [_display, _comment] call zen_comments_fnc_createIcon
 *
 * Public: No
 */

params ["_display", "_comment"];
_comment params ["_id", "", "", "_tooltip"];

private _ctrlIcon = _display ctrlCreate [QGVAR(RscActiveCommentIcon), -1];
_ctrlIcon setVariable [QGVAR(comment), _id];
_ctrlIcon ctrlSetTooltip _tooltip;

GVAR(icons) set [_id, _ctrlIcon];
