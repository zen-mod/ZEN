#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles the display unload event for the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_common_fnc_curatorDisplayUnload
 *
 * Public: No
 */

params ["_display"];

// Emit display unload event
["ZEN_displayCuratorUnload", _display] call CBA_fnc_localEvent;
