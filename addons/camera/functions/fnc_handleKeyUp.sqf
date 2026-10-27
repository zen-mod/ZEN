#include "script_component.hpp"
/*
 * Author: Ampersand, mharis001
 * Handles the key up event for the Zeus display.
 *
 * Arguments:
 * 0: Display (not used) <DISPLAY>
 * 1: Key Code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, 0] call zen_camera_fnc_handleKeyUp
 *
 * Public: No
 */

params ["", "_keyCode"];

if (GVAR(moveCameraKeyHeld) && {_keyCode in actionKeys "curatorMoveCamTo"}) exitWith {
    GVAR(moveCameraKeyHeld) = false;

    // Store how the camera was left
    // Used to recognize repeated activations before the user moves or rotates it
    GVAR(previousMove) set [2, getPosASL curatorCamera];
    GVAR(previousMove) set [3, vectorDir curatorCamera];

    true // handled
};

false
