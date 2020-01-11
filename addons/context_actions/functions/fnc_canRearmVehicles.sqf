#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Checks if the given objects list contains vehicles that can be rearmed.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * Can Rearm Vehicles <BOOL>
 *
 * Example:
 * [_object1, _object2] call zen_context_actions_fnc_canRearmVehicles
 *
 * Public: No
 */

_this findIf {
    private _ammo = [_x] call EFUNC(common,getVehicleAmmo);
    _ammo != -1 && {_ammo < 1}
} != -1
