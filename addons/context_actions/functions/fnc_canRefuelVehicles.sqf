#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Checks if the given objects list contains vehicles that can be refueled.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * Can Refuel Vehicles <BOOL>
 *
 * Example:
 * [_object] call zen_context_actions_fnc_canRefuelVehicles
 *
 * Public: No
 */

_this findIf {fuel _x < 1} != -1
