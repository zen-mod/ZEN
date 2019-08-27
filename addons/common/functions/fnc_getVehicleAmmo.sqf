#include "script_component.hpp"
/*
 * Author: NeilZar
 * Returns the current ammo level of a vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Current Ammo Percentage <NUMBER>
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

// Iterate through all vehicle magazines and calculate ammo percentages for each
private _currentMagazines = (magazinesAllTurrets _vehicle) select {!((_x select 0) in BLACKLIST_MAGAZINES)};

{
    _x params ["_name", "", "_ammo"];

	private _magMaxAmmo = getNumber (_cfgMagazines >> _name >> "count");
	_percentages pushBack (_ammo / _magMaxAmmo);
} forEach _currentMagazines;

// Vehicle has no magazines, return -1 for invalid
if (_percentages isEqualTo []) exitWith {-1};

_percentages call BIS_fnc_arithmeticMean
