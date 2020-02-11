#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Refuels vehicles from the objects list.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call zen_context_actions_fnc_refuelVehicles
 *
 * Public: No
 */

private _vehicles = _this select {
    alive _x
    && {fuel _x < 1}
    && {_x isKindOf "AllVehicles"}
    && {!(_x isKindOf "CAManBase")}
};

{
    [QEGVAR(common,setFuel), [_x, 1], _x] call CBA_fnc_targetEvent;
} forEach _vehicles;
