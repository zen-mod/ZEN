#include "script_component.hpp"
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

params ["_building", "_door"];

if (_building getVariable [VAR_LOCKED(_door), 0] == 1) exitWith {STATE_LOCKED};

[STATE_CLOSED, STATE_OPENED] select (_building animationSourcePhase ANIM_NAME_1(_door) > 0.5)
