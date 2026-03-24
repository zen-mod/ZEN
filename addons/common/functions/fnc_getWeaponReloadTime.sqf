#include "script_component.hpp"
/*
 * Author: Kex
 * Returns the ammo reloading time of the given weapon or muzzle.
 *
 * Arguments:
 * 0: Unit or Vehicle <OBJECT>
 * 1: Turret Path <ARRAY> (default: [0])
 *   - Only used if the given entity is a vehicle.
 * 2: Weapon or Muzzle <STRING> (default: "")
 *   - Use "" for current weapon.
 *
 * Return Value:
 * Reload Time <NUMBER>
 *
 * Example:
 * [_unit, "arifle_MX_F"] call zen_common_fnc_getWeaponReloadTime
 *
 * Public: No
 */

params [
    ["_entity", objNull, [objNull]],
    ["_turretPath", [0], [[]]],
    ["_weaponOrMuzzle", "", [""]]
];

// Get given weapon or muzzle's current state
private _state = if (_entity isKindOf "CAManBase") then {
    _entity weaponState _weaponOrMuzzle
} else {
    weaponState [_entity, _turretPath, _weaponOrMuzzle]
};

_state params ["_weapon", "_muzzle", "_fireMode"];

// Get ammo reloading time
private _config = configFile >> "CfgWeapons" >> _weapon;

if (_muzzle != _weapon) then {
    _config = _config >> _muzzle;
};

if (_muzzle != _fireMode) then {
    _config = _config >> _fireMode;
};

getNumber (_config >> "reloadTime")
