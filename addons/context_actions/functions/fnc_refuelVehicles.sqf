/*
 * Author: 3Mydlo3
 * Refuels units in given selection.
 *
 * Arguments:
 * N: Selected Objects <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle1, vehicle2, vehicle3] call zen_context_actions_fnc_refuelVehicles
 *
 * Public: No
 */
#include "script_component.hpp"

private _vehicles = _this select {alive _x && {_x isKindOf "AllVehicles" && {!(_x isKindOf 'Man')} && {fuel _x < 1}}};

{
    [_x, 1] remoteExecCall ["setFuel", _x];
} forEach _vehicles;
