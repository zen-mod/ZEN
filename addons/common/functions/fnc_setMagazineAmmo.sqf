#include "script_component.hpp"
/*
 * Author: NeilZar
 * Sets the ammo level of the given magazine in the given turret of a vehicle.
 * All magazines of the given type are removed from the turret and then the given number are re-added.
 * The number of rounds in individual magazines depends on the ammo level.
 * This will add as many full magazines as possible instead of evenly distributing the rounds among the magazines.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Turret Path <ARRAY>
 * 2: Magazine Class <STRING>
 * 3: Magazine Count <NUMBER>
 * 4: Ammo Level <NUMBER> (default: 1)
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, [0], "680Rnd_35mm_AA_shells_Tracer_Red", 2, 0.8] call zen_common_fnc_setMagazineAmmo
 *
 * Public: No
 */

params ["_vehicle", "_turretPath", "_magazineClass", "_magazineCount", ["_percentage", 1, [0]]];

private _maxRoundsPerMag = getNumber (configFile >> "CfgMagazines" >> _magazineClass >> "count");
private _totalRounds = round (_magazineCount * _maxRoundsPerMag * _percentage);

_vehicle removeMagazinesTurret [_magazineClass, _turretPath];

for "_i" from 1 to _magazineCount do {
    _vehicle addMagazineTurret [_magazineClass, _turretPath, 0 max _totalRounds min _maxRoundsPerMag];
    _totalRounds = _totalRounds - _maxRoundsPerMag;
};
