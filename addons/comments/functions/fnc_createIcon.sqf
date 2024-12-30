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
 * Icon control for the comment <CONTROL>.
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

_ctrlIcon ctrlAddEventHandler ["KeyDown", {
    params ["_ctrlIcon", "_key"];

    if (_key isNotEqualTo DIK_DELETE) exitWith {};

    private _id = _ctrlIcon getVariable [QGVAR(comment), ""];
    if (_id isEqualTo "") exitWith {};

    if (!GVAR(allowDeleting3DENComments) && {_id call FUNC(is3DENComment)}) exitWith {};

    [QGVAR(deleteComment), [_id]] call CBA_fnc_serverEvent;
}];

GVAR(icons) set [_id, _ctrlIcon];

_ctrlIcon
