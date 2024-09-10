#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the state of the given door for the given building.
 * If a state is not specified, the door's state is cycled.
 *
 * Arguments:
 * 0: Building <OBJECT>
 * 1: Door Index <NUMBER>
 * 2: State <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_building, _door, 0] call zen_doors_fnc_setState
 *
 * Public: No
 */

params ["_building", "_door", "_state"];

// If no state is given, switch the door to the next state (closed -> locked -> opened)
if (isNil "_state") then {
    _state = [_building, _door] call FUNC(getState);
    _state = [STATE_LOCKED, STATE_OPENED, STATE_CLOSED] select _state;
};

_building setVariable [VAR_LOCKED(_door), [0, 1, 0] select _state, true];
_building animateSource [ANIM_NAME_1(_door), [0, 0, 1] select _state, false];
_building animateSource [ANIM_NAME_2(_door), [0, 0, 1] select _state, false];
