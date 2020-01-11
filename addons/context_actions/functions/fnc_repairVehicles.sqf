#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Repairs vehicles from the objects list.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object1, _object2] call zen_context_actions_fnc_repairVehicles
 *
 * Public: No
 */

private _vehicles = _this select {
    alive _x
    && {damage _x > 0}
    && {_x isKindOf "AllVehicles"}
    && {!(_x isKindOf "CAManBase")}
};

{
    _x setDamage 0;
} forEach _vehicles;
