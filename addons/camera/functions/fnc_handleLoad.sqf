#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles initializing the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_camera_fnc_handleLoad
 *
 * Public: No
 */

params ["_display"];

_display displayAddEventHandler ["KeyDown", LINKFUNC(handleKeyDown)];
_display displayAddEventHandler ["KeyUp", LINKFUNC(handleKeyUp)];

// Reset state left over from when the display was last open
GVAR(moveCameraKeyHeld) = false;
GVAR(previousMove) = [];

FUNC(updateSettings) call CBA_fnc_execNextFrame;
