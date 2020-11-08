#include "script_component.hpp"
/*
 * Author: NeilZar
 * Returns the name of the given vehicle's turret weapon.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Weapon Classname <STRING>
 * 2: Turret Path <ARRAY>
 *
 * Return Value:
 * Weapon Name <STRING>
 *
 * Example:
 * [_vehicle, _weapon, _turretPath] call zen_loadout_fnc_getWeaponName
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
