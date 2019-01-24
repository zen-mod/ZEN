/*
 * Author: mharis001
 * Handles the KeyDown event for the garage display.
 *
 * Arguments:
 * 0: Display (not used) <DISPLAY>
 * 1: Key code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, 0] call zen_garage_fnc_onKeyDown
 *
 * Public: No
 */
#include "script_component.hpp"

params ["", "_keyCode"];

if (_keyCode == DIK_ESCAPE) exitWith {
    [] call FUNC(closeGarage);
    true
};

if (_keyCode == DIK_BACKSPACE) exitWith {
    [] call FUNC(toggleInterface);
    true
};

if (_keyCode in actionKeys "nightVision") exitWith {
    GVAR(visionMode) = (GVAR(visionMode) + 1) % 3;

    switch (GVAR(visionMode)) do {
        case 0: {
            camUseNVG false;
            false setCamUseTI 0;
        };
        case 1: {
            camUseNVG true;
            false setCamUseTI 0;
        };
        default {
            camUseNVG false;
            true setCamUseTI 0;
        };
    };

    playSound ["RscDisplayCurator_visionMode", true];

    true
};

false
