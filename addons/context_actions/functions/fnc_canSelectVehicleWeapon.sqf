#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if a vehicle's primary turret has multiple weapons/muzzles/magazines to switch between.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Can Select Vehicle Weapon <BOOL>
 *
 * Example:
 * [_vehicle] call zen_context_actions_fnc_canSelectVehicleWeapon
 *
 * Public: No
 */

params ["_vehicle"];

private _primaryGunner = gunner _vehicle;
private _primaryTurret = [0];

if (isNull _primaryGunner) then {
    _primaryGunner = driver _vehicle;
    _primaryTurret = [-1];
};

if (isNull _primaryGunner) exitWith {};

private _magazines = [];

{
    _x params ["_magazine", "_turretPath", "_count"];
    if (_turretPath isEqualTo _primaryTurret && {_count > 0}) then {
        private _ammo = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");
        private _ammoSimulation = getText (configFile >> "CfgAmmo" >> _ammo >> "simulation");
        if !(_ammoSimulation in AMMO_SIMULATION_BLACKLIST) then {
            _magazines pushBackUnique _magazine;
        };
    };

    if (count _magazines > 1) exitWith {
        true
    };

    false
} forEach magazinesAllTurrets _vehicle
