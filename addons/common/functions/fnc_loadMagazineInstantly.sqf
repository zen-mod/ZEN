#include "script_component.hpp"
/*
 * Author: Kex
 * Instantly loads the given magazine into the specified vehicle's turret weapon.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Turret Path <ARRAY>
 * 2: Weapon <STRING>
 * 3: Magazine <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, [0, 0], "HMG_127_MBT", "200Rnd_127x99_mag_Tracer_Red"] call zen_common_fnc_loadMagazineInstantly
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]], ["_turretPath", [], [[]]], ["_weapon", "", [""]], ["_magazine", "", [""]]];

if !(_vehicle turretLocal _turretPath) exitWith {
    [QGVAR(loadMagazineInstantly), _this, _vehicle, _turretPath] call CBA_fnc_turretEvent;
};

// Get all magazines compatible with the given weapon on the given turret
private _magazines = createHashMap;
private _compatibleMagazines = [_weapon, true] call CBA_fnc_compatibleMagazines;

{
    _x params ["_xMagazine", "_xTurretPath", "_xAmmoCount"];

    if (_turretPath isEqualTo _xTurretPath && {_xMagazine in _compatibleMagazines}) then {
        _magazines getOrDefault [_xMagazine, [], true] pushBack _xAmmoCount;
    };
} forEach magazinesAllTurrets _vehicle;

// Ensure that the vehicle has the desired magazine to load
if (_magazine in _magazines) then {
    // Remove given weapon and all compatible magazines
    _vehicle removeWeaponTurret [_weapon, _turretPath];

    {
        _vehicle removeMagazinesTurret [_x, _turretPath];
    } forEach _magazines;

    // Add magazines of selected type back first (load magazine with most ammo)
    private _selectedMagazine = _magazines deleteAt _magazine;
    _selectedMagazine sort false;

    {
        _vehicle addMagazineTurret [_magazine, _turretPath, _x];
    } forEach _selectedMagazine;

    // Restore weapon and other magazines (will load desired magazine since it was added first)
    _vehicle addWeaponTurret [_weapon, _turretPath];

    {
        private _magazine = _x;

        {
            _vehicle addMagazineTurret [_magazine, _turretPath, _x];
        } forEach _y;
    } forEach _magazines;

    // Select the weapon that the magazine was loaded into
    _vehicle selectWeaponTurret [_weapon, _turretPath];
};
