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
        if (getText (_cfgWeapons >> _x >> "displayName") != "" && !(_x in BLACKLIST_WEAPONS)) then {
            private _weapon = _x;
            TRACE_2("Checking weapon",_weapon,_turret);
            private _magazines = ([_cfgWeapons >> _weapon] call CBA_fnc_compatibleMagazines) apply {
                private _magazine = _x;
                private _count = { (_x select 0) == _magazine && (_x select 1) isEqualTo _turret } count _allMagazines;
                [_magazine, _count]
            };
            TRACE_3("Found magazines in weapon",_weapon,_turret,_magazines);
            if !(_magazines isEqualTo []) then { _result pushback [_weapon, _turret, _magazines] };
        };
    } foreach ((_vehicle weaponsTurret _turret) select {!(toLower(_x) in _pylons)});
} foreach (_vehicle call EFUNC(common,getAllTurrets));

_result
