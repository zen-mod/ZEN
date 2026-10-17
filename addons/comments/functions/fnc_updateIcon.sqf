#include "script_component.hpp"
/*
 * Author: Timi007
 * Updates the icon control of the given comment.
 *
 * Arguments:
 * 0: Comment ID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0"] call zen_comments_fnc_updateIcon
 *
 * Public: No
 */

params ["_id"];

private _ctrlIcon = GVAR(icons) getOrDefault [_id, controlNull];
if (isNull _ctrlIcon) exitWith {};

[_ctrlIcon] call FUNC(updateIconColor);
