#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if a vehicle has a turret with multiple weapons to choose from.
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

private _currentWeapon = currentWeapon _vehicle;
private _currentWeaponMuzzles = getArray (configFile >> "CfgWeapons" >> _currentWeapon >> "muzzles");
private _currentMagazine = currentMagazine _vehicle;

private _primaryGunner = gunner _vehicle;
private _primaryTurret = [0];

if (isNull _primaryGunner) then {
    _primaryGunner = driver _vehicle;
    _primaryTurret = [-1];
};

if (isNull _primaryGunner) exitWith {};

private _currentMuzzle = currentMuzzle _primaryGunner;

private _magazines = [];

{
    _x params ["_magazine", "_turretPath", "_count"];
    if (_turretPath isEqualTo _primaryTurret && {_count > 0}) then {
        private _ammo = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");
        private _ammoSimulation = getText (configFile >> "CfgAmmo" >> _ammo >> "simulation");
        if !(_ammoSimulation in ["shotCM", "laserDesignate"]) then {
            _magazines pushBackUnique _magazine;
        };
    };

    if (count _magazines > 1) exitWith {
        true
    };

    false
} forEach magazinesAllTurrets _vehicle
