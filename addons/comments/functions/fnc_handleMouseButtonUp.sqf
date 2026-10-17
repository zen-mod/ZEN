#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles releasing a mouse button on a comment's icon.
 *
 * Arguments:
 * 0: Mouse Control (not used) <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_comments_fnc_handleMouseButtonUp
 *
 * Public: No
 */

params ["", "_button"];

if (
    _button != 0
    || {GVAR(draggedComment) == ""}
) exitWith {};

// The dragged position was only applied locally, update the comment if it was moved
private _ctrlIcon = GVAR(icons) get GVAR(draggedComment);
private _data = GVAR(comments) get GVAR(draggedComment);
private _oldPos = _ctrlIcon getVariable QGVAR(dragOriginalPos);
private _newPos = _data select DATA_INDEX_POSITION;

if (_newPos isNotEqualTo _oldPos) then {
    [GVAR(draggedComment), _newPos] call FUNC(updateComment);
};

GVAR(draggedComment) = "";

[_ctrlIcon] call FUNC(updateIconColor);
