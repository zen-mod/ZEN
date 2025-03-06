#include "script_component.hpp"
/*
 * Author: Timi007
 * Updates the icon control of comment.
 *
 * Arguments:
 * 0: Comment id <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:2"] call zen_comments_fnc_updateIcon
 *
 * Public: No
 */

params ["_id"];

private _ctrlIcon = GVAR(icons) getOrDefault [_id, controlNull];
if (isNull _ctrlIcon || !(_id in GVAR(comments))) exitWith {};

(GVAR(comments) get _id) params ["", "", ["_tooltip", ""]];

_ctrlIcon ctrlSetTooltip _tooltip;
