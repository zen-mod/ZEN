#include "script_component.hpp"
/*
 * Authors: Timi007
 * Handles unloading the Zeus Display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_plotting_fnc_onUnload
 *
 * Public: No
 */

GVAR(activePlot) = [];
