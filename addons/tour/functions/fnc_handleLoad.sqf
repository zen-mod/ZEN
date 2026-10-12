#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles loading the display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_tour_fnc_handleLoad
 *
 * Public: No
 */

params ["_display"];

uiNamespace setVariable [QGVAR(display), _display];

{
    _x ctrlSetPixelPrecision PIXEL_PRECISION;
    _x ctrlSetFade 1;
    _x ctrlCommit 0;
    _x ctrlSetFade 0;
    _x ctrlCommit INITIAL_FADE_TIME;
} forEach allControls _display;

[LINKFUNC(handleEachFrame), 0, _display] call CBA_fnc_addPerFrameHandler;
