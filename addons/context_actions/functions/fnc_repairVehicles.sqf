/*
 * Author: 3Mydlo3
 * Repairs units in given selection.
 *
 * Arguments:
 * N: Selected Objects <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle1, vehicle2, vehicle3] call zen_context_actions_fnc_repairVehicles
 *
 * Public: No
 */
#include "script_component.hpp"

private _vehicles = _this select {alive _x && {damage _x > 0} && {_x isKindOf "AllVehicles"} && {!(_x isKindOf 'Man')}};

{
    _x setDamage 0;
} forEach _vehicles;
