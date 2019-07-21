#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the ammo level for the given turret of a vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Turret Path <ARRAY>
 * 2: Ammo Level <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, [-1], 0.5] call zen_common_fnc_setTurretAmmo
 *
 * Public: None
 */

params ["_vehicle", "_turretPath", "_percentage"];

private _magazines = [_vehicle, _turretPath] call FUNC(getTurretMagazines);
private _cfgMagazines = configFile >> "CfgMagazines";

{
    private _magazineClass = _x;

    if !(_magazineClass in BLACKLIST_MAGAZINES) then {
        private _maxMagazines = {_x == _magazineClass} count _magazines;
        private _maxRoundsPerMag = getNumber (_cfgMagazines >> _magazineClass >> "count");

        private _totalRounds = round (_maxMagazines * _maxRoundsPerMag * _percentage);
        _vehicle removeMagazinesTurret [_magazineClass, _turretPath];

        while {_totalRounds > 0} do {
            _vehicle addMagazineTurret [_magazineClass, _turretPath, _totalRounds min _maxRoundsPerMag];
            _totalRounds = _totalRounds - _maxRoundsPerMag;
        };
    };
} forEach (_magazines arrayIntersect _magazines);
