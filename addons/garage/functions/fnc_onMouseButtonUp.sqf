/*
 * Author: mharis001
 * Handles the MouseButtonUp event for the garage display.
 *
 * Arguments:
 * 0: Display (not used) <DISPLAY>
 * 1: Button pressed <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, 1] call zen_garage_fnc_onMouseButtonUp
 *
 * Public: No
 */
#include "script_component.hpp"

params ["", "_button"];

GVAR(mouseButtons) set [_button, []];
