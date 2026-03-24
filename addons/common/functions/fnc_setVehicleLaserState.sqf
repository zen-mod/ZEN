#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the state (on/off) of the given vehicle turret's laser weapon.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: State <BOOL> (default: nil)
 *   - Toggles the laser's state when unspecified.
 * 2: Turret Path <ARRAY> (default: [0])
 *   - The primary gunner turret is used by default.
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, true] call zen_common_fnc_setVehicleLaserState
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]], ["_state", nil, [true]], ["_turretPath", [0], [[]]]];

if (!local _vehicle) exitWith {
    [QGVAR(setVehicleLaserState), _this, _vehicle] call CBA_fnc_targetEvent;
};

// Exit if the laser is already turned on/off and we are not toggling it
if (!isNil "_state" && {_vehicle isLaserOn _turretPath isEqualTo _state}) exitWith {};

// Find the correct magazine id and owner and force the laser weapon to fire
{
    _x params ["_xMagazine", "_xTurretPath", "_xAmmoCount", "_id", "_owner"];

    if (
        _turretPath isEqualTo _xTurretPath
        && {_xAmmoCount > 0}
        && {
            private _ammo = getText (configFile >> "CfgMagazines" >> _xMagazine >> "ammo");
            private _ammoSimulation = getText (configFile >> "CfgAmmo" >> _ammo >> "simulation");
            _ammoSimulation == "laserDesignate"
        }
    ) exitWith {
        _vehicle action ["UseMagazine", _vehicle, _vehicle turretUnit _turretPath, _owner, _id];
    };
} forEach magazinesAllTurrets _vehicle;
