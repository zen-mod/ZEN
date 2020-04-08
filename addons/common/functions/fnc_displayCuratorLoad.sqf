#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles the display load event for the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_common_fnc_displayCuratorLoad
 *
 * Public: No
 */

params ["_display"];

// Remove "Gear" animation when entering Zeus
if (GVAR(disableGearAnim) && {vehicle player == player}) then {
    [{player switchMove _this}, animationState player] call CBA_fnc_execNextFrame;
};

// Emit display load event
["zen_curatorDisplayLoaded", _display] call CBA_fnc_localEvent;
