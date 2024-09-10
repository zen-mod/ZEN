#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the formation of the given groups.
 *
 * Arguments:
 * 0: Groups <ARRAY>
 * 1: Formation <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_groups, "WEDGE"] call zen_context_actions_fnc_setFormation
 *
 * Public: No
 */

params ["_groups", "_formation"];

{
    [QEGVAR(common,setFormation), [_x, _formation], _x] call CBA_fnc_targetEvent;
} forEach _groups;
