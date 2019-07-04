/*
 * Author: 3Mydlo3
 * Repairs units in given selection.
 *
 * Arguments:
 * N: Selected Objects <OBJECT>
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

private _vehicles = _this select {alive _x && {_x isKindOf "AllVehicles" && {!(_x isKindOf 'Man')} && {damage _x > 0}}};

{
    _x setDamage 0;
} forEach _vehicles;
