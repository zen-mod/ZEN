#include "script_component.hpp"
/*
 * Author: NeilZar
 * Get all turret weapons from the passed vehicle, the compatible magazines, and a count of each magazine currently in the turret.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Array of all weapons and their magazines <ARRAY>
 *
 * Example:
 * [_vehicle] call zen_loadout_fnc_getWeaponList
 *
 * Public: No
 */

params ["_vehicle"];

private _pylons = (getPylonMagazines _vehicle) apply {toLower (getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon"))};
private _cfgWeapons = configFile >> "CfgWeapons";
private _allMagazines = magazinesAllTurrets _vehicle;

private _result = [];
{
    private _turret = _x;
    {
        if (getText (_cfgWeapons >> _x >> "displayName") != "" && (([_x] call BIS_fnc_returnParents) arrayIntersect BLACKLIST_WEAPONS isEqualTo [])) then {
            private _weapon = _x;

            private _magazines = ([_cfgWeapons >> _weapon, true] call CBA_fnc_compatibleMagazines) apply {
                private _magazine = _x;
                private _count = { (_x select 0) == _magazine && (_x select 1) isEqualTo _turret } count _allMagazines;
                [_magazine, _count]
            };

            if !(_magazines isEqualTo []) then { _result pushback [_weapon, _turret, _magazines] };
        };
    } foreach ((_vehicle weaponsTurret _turret) select {!(toLower(_x) in _pylons)});
} foreach (_vehicle call EFUNC(common,getAllTurrets));

_result
