#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the behaviour of the given groups.
 *
 * Arguments:
 * 0: Groups <ARRAY>
 * 1: Behaviour <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_groups, "AWARE"] call zen_context_actions_fnc_setBehaviour
 *
 * Public: No
 */

params ["_groups", "_behaviour"];

{
    [QEGVAR(common,setBehaviour), [_x, _behaviour], _x] call CBA_fnc_targetEvent;
} forEach _groups;
