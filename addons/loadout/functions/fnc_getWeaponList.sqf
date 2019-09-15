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
            private _magazines = [];
            private _weapon = _x;
            TRACE_2("Checking weapon",_weapon,_turret);
            {
                TRACE_3("Checking weapon muzzle",_weapon,_turret,_x);
                private _temp = getArray ((if (_x isEqualTo "this") then { _cfgWeapons >> _weapon } else { _cfgWeapons >> _weapon >> _x }) >> "magazines");
                _magazines append (_temp apply {
                    private _magazine = _x;
                    private _count = { (_x select 0) == _magazine && (_x select 1) isEqualTo _turret } count _allMagazines;
                    [_magazine, _count]
                });
                TRACE_4("Found magazines in weapon muzzle",_weapon,_turret,_x,_temp);
            } forEach getArray (_cfgWeapons >> _weapon >> "muzzles");
            TRACE_3("Found magazines in weapon",_weapon,_turret,_magazines);
            if !(_magazines isEqualTo []) then { _result pushback [_weapon, _turret, _magazines] };
        };
    } foreach ((_vehicle weaponsTurret _turret) select {!(toLower(_x) in _pylons)});
} foreach (_vehicle call EFUNC(common,getAllTurrets));

_result
