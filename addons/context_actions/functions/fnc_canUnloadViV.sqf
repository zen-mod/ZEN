#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if the given objects list contains Vehicle-in-Vehicle cargo or carriers that can be unloaded.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * Can Unload Vehicles <BOOL>
 *
 * Example:
 * [_object] call zen_context_actions_fnc_canUnloadViV
 *
 * Public: No
 */

_this findIf {!(getVehicleCargo _x isEqualTo []) || {!isNull isVehicleCargo _x}} != -1
