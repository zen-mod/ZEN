#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates an icon control for the comment.
 *
 * Arguments:
 * 0: Unique comment id <STRING>
 * 1: Comment position ASL <ARRAY>
 * 2: Comment title <STRING>
 * 3: Comment tooltip <STRING>
 * 4: Comment color (RGBA) <ARRAY>
 * 5: Name of the curator that created the comment <STRING>
 *
 * Return Value:
 * Icon control for the comment <CONTROL>.
 *
 * Example:
 * ["zeus:1", [0,0,0], "My Comment", "This is a nice comment", [1,0,0,0.7], "Joe"] call zen_comments_fnc_createIcon
 *
 * Public: No
 */

params ["_id", "", "", "_tooltip"];

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
if (isNull _display) exitWith {};

private _ctrlIcon = _display ctrlCreate [QGVAR(RscActiveCommentIcon), -1];
_ctrlIcon setVariable [QGVAR(comment), _id];
_ctrlIcon ctrlSetTooltip _tooltip;

_ctrlIcon ctrlAddEventHandler ["KeyDown", FUNC(onKeyDown)];
_ctrlIcon ctrlAddEventHandler ["MouseButtonDblClick", FUNC(onMouseDblClick)];

GVAR(icons) set [_id, _ctrlIcon];

_ctrlIcon
