#include "script_component.hpp"
/*
 * Author: NeilZar
 * Returns a list of all turret weapons with the count of every compatible
 * magazine current in the turret from the given vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Weapon List <ARRAY>
 *   N: [Weapon <STRING>, Turret Path <ARRAY>, Magazines <ARRAY>] <ARRAY>
 *
 * Example:
 * [_vehicle] call zen_loadout_fnc_getWeaponList
 *
 * Public: No
 */

params ["_vehicle"];

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";
private _pylonWeapons = getPylonMagazines _vehicle apply {toLower getText (_cfgMagazines >> _x >> "pylonWeapon")};
private _allMagazines = magazinesAllTurrets _vehicle;

private _weaponList = [];

{
    private _turretPath = _x;

    {
        private _weapon = _x;
        private _weaponConfig = _cfgWeapons >> _x;

        if (
            getText (_weaponConfig >> "displayName") != ""
            && {!(toLower _weapon in _pylonWeapons)}
            && {[_weaponConfig, true] call BIS_fnc_returnParents arrayIntersect BLACKLIST_WEAPONS isEqualTo []}
        ) then {
            private _magazines = [_weaponConfig, true] call CBA_fnc_compatibleMagazines apply {
                private _magazine = _x;
                private _count = {(_x select 0) == _magazine && {(_x select 1) isEqualTo _turretPath}} count _allMagazines;

                [_magazine, _count]
            };

            if (_magazines isEqualTo []) exitWith {};

            _weaponList pushBack [_weapon, _turretPath, _magazines];
        };
    } forEach (_vehicle weaponsTurret _turretPath);
} forEach (_vehicle call EFUNC(common,getAllTurrets));

_weaponList
