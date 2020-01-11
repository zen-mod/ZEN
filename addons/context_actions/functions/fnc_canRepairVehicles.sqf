#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Checks if the given objects list contains vehicles that can be repaired.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * Can Repair Vehicles <BOOL>
 *
 * Example:
 * [_object1, _object2] call zen_context_actions_fnc_canRepairVehicles
 *
 * Public: No
 */

_this findIf {damage _x > 0 && {_x isKindOf "AllVehicles"} && {!(_x isKindOf "CAManBase")}} != -1
