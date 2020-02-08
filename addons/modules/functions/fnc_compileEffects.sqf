#include "script_component.hpp"
/*
 * Author: mharis001
 * Compiles a list of all infantry attachable effects.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_modules_fnc_compileEffects
 *
 * Public: No
 */

private _effectsCache = [[""], [["STR_A3_None", "", QPATHTOF(ui\none_ca.paa)]]];
_effectsCache params ["_effectTypes", "_effectNames"];

private _cfgAmmo = configFile >> "CfgAmmo";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgWeapons = configFile >> "CfgWeapons";

{
    {
        private _config = _cfgMagazines >> _x;

        if (getNumber (_config >> "scope") == 2) then {
            private _ammo = getText (_config >> "ammo");

            if (getNumber (_cfgAmmo >> _ammo >> "explosive") == 0) then {
                _effectTypes pushBack _ammo;
                _effectNames pushBack [getText (_config >> "displayName"), "", getText (_config >> "picture")];
            };
        };
    } forEach getArray (_cfgWeapons >> "Throw" >> _x >> "magazines");
} forEach getArray (_cfgWeapons >> "Throw" >> "muzzles");

uiNamespace setVariable [QGVAR(effectsCache), _effectsCache];
