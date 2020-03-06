#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Rearms vehicles from the objects list.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call zen_context_actions_fnc_rearmVehicles
 *
 * Public: No
 */

private _vehicles = _this select {
    alive _x
    && {_x isKindOf "AllVehicles"}
    && {!(_x isKindOf "CAManBase")}
    && {
        private _ammo = [_x] call EFUNC(common,getVehicleAmmo);
        _ammo != -1 && {_ammo < 1}
    }
};

{
    [_x, 1] call EFUNC(common,setVehicleAmmo);
} forEach _vehicles;
