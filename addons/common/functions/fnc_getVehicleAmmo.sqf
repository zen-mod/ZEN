#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the current ammo level of a vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Current Ammo <NUMBER>
 *
 * Example:
 * [vehicle player] call zen_common_fnc_getVehicleAmmo
 *
 * Public: No
 */

params ["_vehicle"];

private _percentages  = [];
private _cfgMagazines = configFile >> "CfgMagazines";

// Iterate through all vehicle pylons and add pylon ammo percentages
{
    private _magazineClass = _x;

    if (_magazineClass != "") then {
        private _maxRoundsPerMag = getNumber (_cfgMagazines >> _magazineClass >> "count");
        private _currentRounds = _vehicle ammoOnPylon (_forEachIndex + 1);

        _percentages pushBack (_currentRounds / _maxRoundsPerMag);
    };
} forEach getPylonMagazines _vehicle;

// Iterate through all vehicle turrets and calculate ammo percentages for all magazines
private _turretMagazines = magazinesAllTurrets _vehicle;

{
    private _turretPath = _x;
    private _magazines = [_vehicle, _turretPath] call FUNC(getTurretMagazines);

    {
        private _magazineClass = _x;

        if !(_magazineClass in BLACKLIST_MAGAZINES) then {
            private _maxMagazines = {_x == _magazineClass} count _magazines;
            private _maxRoundsPerMag = getNumber (_cfgMagazines >> _magazineClass >> "count");

            private _currentRounds = _turretMagazines select {(_x select 0) isEqualTo _magazineClass && {(_x select 1) isEqualTo _turretPath}} apply {_x select 2};
            private _currentMagazines = count _currentRounds;

            // Add percentage of remaining rounds for existing magazines
            {
                _percentages pushBack (_x / _maxRoundsPerMag);
            } forEach _currentRounds;

            // Add 0 for missing magazines from max magazine count
            for "_i" from 1 to (_maxMagazines - _currentMagazines) do {
                _percentages pushBack 0;
            };
        };
    } forEach (_magazines arrayIntersect _magazines);
} forEach (_vehicle call FUNC(getAllTurrets));

// Vehicle has no magazines, return -1 for invalid
if (_percentages isEqualTo []) exitWith {-1};

_percentages call BIS_fnc_arithmeticMean
