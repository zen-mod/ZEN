/*
 * Author: mharis001
 * Sets the behaviour of groups in given selection.
 *
 * Arguments:
 * 0: Groups <ARRAY>
 * 1: Behaviour <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[group], "AWARE"] call zen_context_actions_fnc_setBehaviour
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_groups", "_behaviour"];

{
    [QEGVAR(common,setBehaviour), [_x, _behaviour], _x] call CBA_fnc_targetEvent;
} forEach _groups;
