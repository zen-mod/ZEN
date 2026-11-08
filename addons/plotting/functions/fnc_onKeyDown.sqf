#include "script_component.hpp"
/*
 * Authors: Timi007
 * Handles canceling the currently active plot.
 *
 * Arguments:
 * 0: Display or control the EH is attached to (ignored) <DISPLAY or CONTROL>
 * 1: Key code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [_display, 1] call zen_plotting_fnc_onKeyDown
 *
 * Public: No
 */

params ["", "_keyCode"];

if (GVAR(activePlot) isEqualTo [] || {_keyCode != DIK_ESCAPE}) exitWith {false};

TRACE_1("Cancel adding plot",_this);
GVAR(activePlot) = [];

true
