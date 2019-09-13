#include "script_component.hpp"
/*
 * Author: NeilZar
 * Sets the ammo level for the given magazine in the given turret of a vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Magazine <ARRAY>
 *   0: Class Name <STRING>
 *   1: Turret Path <ARRAY>
 *   2: Max Magazine Ammo <NUMBER>
 *   3: Magazine Count <NUMBER>
 * 2: Ammo Level <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, ["680Rnd_35mm_AA_shells_Tracer_Red", [0], 2], 0.8] call zen_common_fnc_setMagazineAmmo
 *
 * Public: No
 */

params ["_vehicle", "_magazine", ["_percentage", 1, [0]]];
_magazine params ["_magazineClass", "_turretPath", "_magazineCount"];

private _maxRoundsPerMag = getNumber (configFile >> "CfgMagazines" >> _magazineClass >> "count");

private _totalRounds = round (_magazineCount * _maxRoundsPerMag * _percentage);
_vehicle removeMagazinesTurret [_magazineClass, _turretPath];

for "_i" from 1 to _magazineCount do {
    _vehicle addMagazineTurret [_magazineClass, _turretPath, 0 max _totalRounds min _maxRoundsPerMag];
    _totalRounds = _totalRounds - _maxRoundsPerMag;
};
