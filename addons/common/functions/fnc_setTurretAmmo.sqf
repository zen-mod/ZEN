#include "script_component.hpp"
/*
 * Author: mharis001, NeilZar
 * Sets the ammo level for the given magazine in the given turret of a vehicle.
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
 * [vehicle player, [0], 0.8] call zen_common_fnc_setTurretAmmo
 *
 * Public: No
 */

params ["_vehicle", "_turretPath", "_percentage"];

private _magazines = _vehicle magazinesTurret _turretPath;
private _pylonMags = getPylonMagazines _vehicle;

{
    private _magazineClass = _x;

    if !(_magazineClass in _pylonMags || {_magazineClass in BLACKLIST_MAGAZINES}) then {
        private _magazineCount = {_x == _magazineClass} count _magazines;
        [_vehicle, [_x, _turretPath, _magazineCount], _percentage] call FUNC(setMagazineAmmo);
    };
} forEach (_magazines arrayIntersect _magazines);
