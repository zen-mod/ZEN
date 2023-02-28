#include "script_component.hpp"
/*
 * Author: mharis001, Ampersand
 * Makes the given unit fire their [vehicle turret's] weapon.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call zen_common_fnc_forceFire
 *
 * Public: No
 */

params ["_unit", ["_ignoreAmmo", false]];

// If a vehicle is given directly, use the first turret that can fire
if !(_unit isKindOf "CAManBase") exitWith {
    [[_unit] call FUNC(firstTurretUnit)] call FUNC(forceFire);
};

private _vehicle = vehicle _unit;

switch (true) do {
    // On foot
    case (_vehicle == _unit): {
        weaponState _unit params ["_weapon", "_muzzle", "_fireMode"];

        if (_ignoreAmmo) then {_unit setAmmo [_weapon, 1e6];};
        _unit forceWeaponFire [_muzzle, _fireMode];
    };

    // FFV
    case (_unit call EFUNC(common,isUnitFFV)): {
        // Using UseMagazine action since forceWeaponFire command does not work for FFV units
        // UseMagazine action doesn't seem to work with currently loaded magazine (currentMagazineDetail)
        // Therefore, this relies on the unit having an extra magazine in their inventory
        // but should be fine in most situations
        private _weapon = currentWeapon _unit;
        private _compatibleMagazines = _weapon call CBA_fnc_compatibleMagazines;
        private _index = magazines _unit findAny _compatibleMagazines;
        if (_index == -1) exitWith {};

        private _magazine = magazinesDetail _unit select _index;
        _magazine call EFUNC(common,parseMagazineDetail) params ["_id", "_owner"];

        if (_ignoreAmmo) then {_unit setAmmo [_weapon, 1e6];};
        CBA_logic action ["UseMagazine", _unit, _unit, _owner, _id];
    };

    // Vehicle driver horn
    case (driver _vehicle == _unit): {
        weaponState [_vehicle, [-1]] params ["_weapon", "_muzzle", "_firemode"];
        if (_ignoreAmmo) then {_unit setAmmo [_muzzle, 1e6];};
        _unit forceWeaponFire [_muzzle, _firemode];
    };

    // Vehicle gunner
    default {
        private _turretPath = _vehicle unitTurret _unit;
        private _muzzle = weaponState [_vehicle, _turretPath] select 1;
        if (_ignoreAmmo) then {_unit setAmmo [_muzzle, 1e6];};

        private _magazine = _vehicle currentMagazineDetailTurret _turretPath;
        _magazine call EFUNC(common,parseMagazineDetail) params ["_id", "_owner"];
        _vehicle action ["UseMagazine", _vehicle, _unit, _owner, _id];
    };
};
