#include "script_component.hpp"
/*
 * Author: mharis001, NeilZar
 * Returns the current ammo level (0..1) of a vehicle.
 * -1 is returned if the vehicle has no magazines.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Ammo Level <NUMBER>
 *
 * Example:
 * [vehicle player] call zen_common_fnc_getVehicleAmmo
 *
 * Public: No
 */

params ["_vehicle"];

// Get current state of all magazines
private _percentages  = [];
private _cfgMagazines = configFile >> "CfgMagazines";

// Calculate ammo percentages for all vehicle magazines
{
    _x params ["_magazineClass", "", "_currentAmmo"];

    if !(_magazineClass in BLACKLIST_MAGAZINES) then {
    	private _maxAmmo = getNumber (_cfgMagazines >> _magazineClass >> "count");
    	_percentages pushBack _currentAmmo / _maxAmmo;
    };
} forEach magazinesAllTurrets _vehicle;

// Vehicle has no magazines, return -1 for invalid
if (_percentages isEqualTo []) exitWith {-1};

_percentages call BIS_fnc_arithmeticMean
