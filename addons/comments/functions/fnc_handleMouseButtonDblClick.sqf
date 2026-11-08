#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles double clicking a mouse button on a comment's icon.
 *
 * Arguments:
 * 0: Mouse Control (not used) <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_comments_fnc_handleMouseButtonDblClick
 *
 * Public: No
 */

params ["", "_button"];

if (
    _button != 0
    || {GVAR(hoveredComment) == ""}
    || {GVAR(hoveredComment) call FUNC(is3DENComment)}
) exitWith {};

// If dragging was started, the dialog prevents triggering the mouse button up event that stops it
[] call FUNC(stopDragging);

[GVAR(hoveredComment)] call FUNC(openDialog);
