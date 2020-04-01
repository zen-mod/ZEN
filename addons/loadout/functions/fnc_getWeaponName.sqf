#include "script_component.hpp"
/*
 * Author: NeilZar
 * Get the name of the passed weapon and the turret position.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Weapon class name <STRING>
 * 2: Turret path <ARRAY>
 *
 * Return Value:
 * Weapon name and turret <STRING>
 *
 * Example:
 * [_vehicle, _weapon, _turret] call zen_loadout_fnc_getWeaponName
 *
 * Public: No
 */

params ["_vehicle", "_weapon", "_turret"];

private _weaponName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
private _turretCopy = +_turret;
private _path = configFile >> "CfgVehicles" >> typeOf _vehicle;

if !(_turretCopy isEqualTo [-1]) then {
    while {!(_turretCopy isEqualTo [])} do {
        _path = _path >> "Turrets";
        private _index = _turretCopy deleteAt 0;
        _path = (_path select _index);
    };
};

private _gunnerName = [_path >> "gunnerName", "STRING", "Pilot/Driver"] call CBA_fnc_getConfigEntry;

format ["%1 (%2)", _weaponName, _gunnerName]
