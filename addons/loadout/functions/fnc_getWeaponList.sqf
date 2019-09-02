#include "script_component.hpp"
/*
 * Author: NeilZar
 * Populates the listbox with items from the current weapon.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_loadout_fnc_fillList
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
        if (getText (_cfgWeapons >> _x >> "displayName") != "") then {
            private _magazines = [];
            private _weapon = _x;
            {
                private _temp = getArray ((if (_x isEqualTo "this") then { _cfgWeapons >> _weapon } else { _cfgWeapons >> _weapon >> _x }) >> "magazines");
                _magazines append (_temp apply {
                    private _magazine = _x;
                    private _count = { (_x select 0) == _magazine && (_x select 1) isEqualTo _turret } count _allMagazines;
                    [_magazine, _count]
                });
            } forEach getArray (_cfgWeapons >> _weapon >> "muzzles");
            _result pushback [_weapon, _turret, _magazines];
        };
    } foreach ((_vehicle weaponsTurret _turret) select {!(toLower(_x) in _pylons)});
} foreach allTurrets _vehicle;

_result
