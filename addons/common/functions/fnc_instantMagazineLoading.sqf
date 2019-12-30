#include "script_component.hpp"
/*
 * Author: Kex
 * Instantly loads the given magazine into the specified weapon.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Turret path <ARRAY>
 * 2: Muzzle class <STRING>
 * 3: Magazine class <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, [0] "HE", "60Rnd_40mm_GPR_Tracer_Red_shells"] call zen_common_fnc_instantMagazineLoading;
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]], ["_turretPath", [], [[]]], ["_muzzle", "", [""]], ["_magazine", "", [""]]];

private _magazines = _vehicle magazinesTurret _turretPath;
private _magIdx = _magazines findIf {_x == _magazine};
if (_magIdx >= 0) then {
    private _magazinesUnique = _magazines arrayIntersect _magazines;
    private _ammoArray = _magazinesUnique apply {_vehicle magazineTurretAmmo [_x, _turretPath]};

    // Remove weapon and magazines
    {
        _vehicle removeMagazinesTurret [_x, _turretPath] 
    } forEach _magazinesUnique;
    _vehicle removeWeaponTurret [_muzzle, _turretPath];

    // Add desired magazine first
    _vehicle addMagazineTurret [_magazine, _turretPath];
    _magazines deleteAt _magIdx;

    // Restore weapon and magazines
    _vehicle addWeaponTurret [_muzzle, _turretPath];
    {
        _vehicle addMagazineTurret [_x, _turretPath];
    } forEach _magazines;
    {
        _vehicle setMagazineTurretAmmo [_magazinesUnique select _forEachIndex, _x, _turretPath];
    } forEach _ammoArray;
};
