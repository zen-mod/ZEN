/*
 * Author: mharis001
 * Returns the current state of the door for the given building.
 *
 * Arguments:
 * 0: Building <OBJECT>
 * 1: Door Index <NUMBER>
 *
 * Return Value:
 * Door State <NUMBER>
 *
 * Example:
 * [building, 1] call zen_doors_fnc_getState
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_building", "_door"];

if (_building getVariable [LOCKED_VAR(_door), 0] == 1) exitWith {STATE_LOCKED};

[STATE_CLOSED, STATE_OPENED] select (_building animationSourcePhase ANIM_NAME_1(_door) > 0.5);
