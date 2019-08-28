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

private _result = [];
{
    private _turret = _x;
    {
        _result pushback [_x, _turret];
    } foreach ((object weaponsTurret _turret) select {!(toLower(_x) in _pylons)});
} foreach allTurrets _vehicle;

_result
