#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles unloading the Zeus Display.
 *
 * Arguments:
 * 0: Display (not used) <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_area_markers_fnc_handleUnload
 *
 * Public: No
 */

GVAR(visibilityPFH) call CBA_fnc_removePerFrameHandler;
GVAR(visibilityPFH) = nil;
