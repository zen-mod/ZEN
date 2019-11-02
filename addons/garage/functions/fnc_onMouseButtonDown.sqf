#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles the MouseButtonDown event for the garage display.
 *
 * Arguments:
 * 0: Display (not used) <DISPLAY>
 * 1: Button pressed <NUMBER>
 * 2: Mouse X position <NUMBER>
 * 3: Mouse Y position <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, 1, 0.5, 0.5] call zen_garage_fnc_onMouseButtonDown
 *
 * Public: No
 */

params ["", "_button", "_mouseX", "_mouseY"];

GVAR(mouseButtons) set [_button, [_mouseX, _mouseY]];
