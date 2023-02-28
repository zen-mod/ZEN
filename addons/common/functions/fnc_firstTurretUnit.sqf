#include "script_component.hpp"
/*
 * Author: Ampersand
 * Returns the unit in the given vehicle's first turret that is able to fire. Order is Gunner, commander, other turrets, driver. FFV excluded.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Turret Path <ARRAY>
 *
 * Example:
 * [_vehicle] call zen_common_fnc_firstTurretUnit
 *
 * Public: No
 */

params [["_vehicle", objNull]];

if (isNull _vehicle) exitWith {objNull};

private _firstTurretUnit = objNull;
{
    private _unit = _vehicle turretUnit _x;
    if ([_unit] call FUNC(canFire)) exitWith {
        _firstTurretUnit = _unit
    };
} forEach allTurrets _vehicle + [[-1]];

_firstTurretUnit
