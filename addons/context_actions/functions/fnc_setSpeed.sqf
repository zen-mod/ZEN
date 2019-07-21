#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the speed mode of groups in given selection.
 *
 * Arguments:
 * 0: Groups <ARRAY>
 * 1: Speed <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[group], "NORMAL"] call zen_context_actions_fnc_setBehaviour
 *
 * Public: No
 */

params ["_groups", "_speed"];

{
    [QEGVAR(common,setSpeedMode), [_x, _speed], _x] call CBA_fnc_targetEvent;
} forEach _groups;
