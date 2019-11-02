#include "script_component.hpp"
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

private _vehicles = _this select {
    alive _x
    && {fuel _x < 1}
    && {_x isKindOf "AllVehicles"}
    && {!(_x isKindOf 'CAManBase')}
};

{
    [QEGVAR(common,setFuel), [_x, 1], _x] call CBA_fnc_targetEvent;
} forEach _vehicles;
