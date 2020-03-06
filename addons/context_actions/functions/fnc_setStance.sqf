#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the stance of AI units in the given objects list.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: Stance <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_objects, "AUTO"] call zen_context_actions_fnc_setStance
 *
 * Public: No
 */

params ["_objects", "_stance"];

{
    if (alive _x && {_x isKindOf "CAManBase"} && {!isPlayer _x}) then {
        [QEGVAR(common,setUnitPos), [_x, _stance], _x] call CBA_fnc_targetEvent;
    };
} forEach _objects;
