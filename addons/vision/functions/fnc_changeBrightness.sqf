/*
 * Author: mharis001
 * Changes the current NVG brightness. Called from keybindings.
 *
 * Arguments:
 * 0: Change <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [1] call zen_vision_fnc_changeBrightness
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_change"];

// Update current brightness and trigger effects update
GVAR(brightness) = MIN_BRIGHTNESS max (GVAR(brightness) + _change) min MAX_BRIGHTNESS;
[] call FUNC(updateEffect);

// Display hint for current brightness level
[localize LSTRING(Brightness), GVAR(brightness)] call EFUNC(common,showMessage);
playSound "Click";
