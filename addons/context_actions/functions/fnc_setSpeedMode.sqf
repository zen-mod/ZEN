#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the speed mode of the given groups.
 *
 * Arguments:
 * 0: Groups <ARRAY>
 * 1: Speed Mode <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_groups, "NORMAL"] call zen_context_actions_fnc_setSpeedMode
 *
 * Public: No
 */

params ["_groups", "_speedMode"];

{
    [QEGVAR(common,setSpeedMode), [_x, _speedMode], _x] call CBA_fnc_targetEvent;
} forEach _groups;
