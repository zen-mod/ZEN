/*
 * Author: mharis001
 * Cycles the state of a door. Called from the door button click EH.
 *
 * Arguments:
 * 0: Door Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_doors_fnc_setState
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_control"];

private _building = _control getVariable QGVAR(building);
private _door     = _control getVariable QGVAR(door);

private _state = [_building, _door] call FUNC(getState);
_state = floor ((_state + 1) % 3);

_building setVariable [LOCKED_VAR(_door), [0, 1, 0] select _state, true];
_building animateSource [ANIM_NAME_1(_door), [0, 0, 1] select _state, false];
_building animateSource [ANIM_NAME_2(_door), [0, 0, 1] select _state, false];
