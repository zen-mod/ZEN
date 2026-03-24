#include "script_component.hpp"
/*
 * Author: mharis001, Ampersand
 * Handles the key up event for the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Key Code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, 0] call zen_editor_fnc_handleKeyUp
 *
 * Public: No
 */

params ["_display", "_keyCode"];

if (_keyCode in actionKeys "curatorPingView" && {!isNil QGVAR(pingTarget)}) exitWith {
    GVAR(pingViewed) = nil;
    true // handled
};

false
