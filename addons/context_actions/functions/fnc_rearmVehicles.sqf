/*
 * Author: 3Mydlo3
 * Rearms units in given selection.
 *
 * Arguments:
 * N: Selected Objects <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle1, vehicle2, vehicle3] call zen_context_actions_fnc_rearmVehicles
 *
 * Public: No
 */
#include "script_component.hpp"

private _vehicles = _this select {
    alive _x
    && {
        private _ammo = [_x] call EFUNC(common,getVehicleAmmo);
        _ammo != -1
        && {_ammo < 1}
    }
    && {_x isKindOf "AllVehicles"}
    && {!(_x isKindOf 'CAManBase')}
};

{
    [_x, 1] call EFUNC(common,setVehicleAmmo);
} forEach _vehicles;
