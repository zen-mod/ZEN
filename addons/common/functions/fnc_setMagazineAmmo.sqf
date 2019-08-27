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
 * [vehicle player, ["680Rnd_35mm_AA_shells_Tracer_Red", [0], 680, 2], 900] call zen_common_fnc_setTurretAmmo
 *
 * Public: No
 */

params ["_vehicle", "_magazine", "_percentage"];
_magazine params ["_name", "_turretPath", "_magMaxAmmo", "_magCount"];

private _totalAmmo = round (_magMaxAmmo * _magCount * _percentage);
_vehicle removeMagazinesTurret [_name, _turretPath];

for "_i" from 1 to _magCount do {
    private _magAmmo = _magMaxAmmo min _totalAmmo;
    _vehicle addMagazineTurret [_name, _turretPath, _magAmmo];
    _totalAmmo = _totalAmmo - _magMaxAmmo;
};
