#include "script_component.hpp"
/*
 * Author: NeilZar
 * Get all turret weapons from the passed vehicle, the compatible magazines,
 * and a count of each magazine currently in the turret. Formatted as
 * [Weapon, Turret Path, Magazines] for each array entry. Magazines is an array.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Weapon List <ARRAY>
 *
 * Example:
 * [_vehicle] call zen_loadout_fnc_getWeaponList
 *
 * Public: No
 */

params ["_vehicle"];

private _cfgMagazines = configFile >> "CfgMagazines";
private _pylonWeapons = getPylonMagazines _vehicle apply {toLower getText (_cfgMagazines >> _x >> "pylonWeapon")};
private _cfgWeapons = configFile >> "CfgWeapons";
private _allMagazines = magazinesAllTurrets _vehicle;

private _weaponList = [];
{
    private _turretPath = _x;
    {
        private _cfgWeapon = _cfgWeapons >> _x;
        if (
            getText (_cfgWeapon >> "displayName") != ""
            && !(toLower(_x) in _pylonWeapons)
            && ([_cfgWeapon, true] call BIS_fnc_returnParents arrayIntersect BLACKLIST_WEAPONS isEqualTo [])
        )then {
            private _magazines = [_cfgWeapon, true] call CBA_fnc_compatibleMagazines apply {
                private _magazine = _x;
                private _count = {(_x select 0) == _magazine && (_x select 1) isEqualTo _turretPath} count _allMagazines;
                [_magazine, _count]
            };

            if !(_magazines isEqualTo []) then {_weaponList pushback [_x, _turretPath, _magazines]};
        };
    } forEach (_vehicle weaponsTurret _turretPath);
} forEach (_vehicle call EFUNC(common,getAllTurrets));

_weaponList
