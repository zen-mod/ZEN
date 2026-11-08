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

if (_button != 0) exitWith {};

[true] call FUNC(stopDragging);
