#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the combat mode of the given groups.
 *
 * Arguments:
 * 0: Groups <ARRAY>
 * 1: Combat Mode <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_groups, "YELLOW"] call zen_context_actions_fnc_setCombatMode
 *
 * Public: No
 */

params ["_groups", "_combatMode"];

{
    [QEGVAR(common,setCombatMode), [_x, _combatMode], _x] call CBA_fnc_targetEvent;
} forEach _groups;
