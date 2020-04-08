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
 * Weapon and turret names <STRING>
 *
 * Example:
 * [_vehicle, _weapon, _turret] call zen_loadout_fnc_getWeaponName
 *
 * Public: No
 */

params ["_vehicle", "_weapon", "_turretPath"];

private _weaponName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
private _gunnerName = getText ([_vehicle, _turretPath] call CBA_fnc_getTurret >> "gunnerName");

if (_gunnerName == "") then {
    _gunnerName = localize (["str_driver", "str_pilot"] select (_vehicle isKindOf "Air"));
};

format ["%1 (%2)", _weaponName, _gunnerName]
