#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates an icon control for the comment.
 *
 * Arguments:
 * 0: Unique comment id <STRING>
 *
 * Return Value:
 * Icon control for the comment <CONTROL>.
 *
 * Example:
 * ["zeus:0"] call zen_comments_fnc_createIcon
 *
 * Public: No
 */

params ["_id"];

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
if (isNull _display || !(_id in GVAR(comments))) exitWith {};

(GVAR(comments) get _id) params ["", "", ["_tooltip", ""]];

private _ctrlIcon = _display ctrlCreate [QGVAR(RscActiveCommentIcon), -1];
_ctrlIcon setVariable [QGVAR(comment), _id];
_ctrlIcon ctrlSetTooltip _tooltip;

_ctrlIcon ctrlAddEventHandler ["KeyDown", FUNC(onKeyDown)];
_ctrlIcon ctrlAddEventHandler ["MouseButtonDblClick", FUNC(onMouseDblClick)];

GVAR(icons) set [_id, _ctrlIcon];

_ctrlIcon
