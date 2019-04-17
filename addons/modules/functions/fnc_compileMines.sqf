/*
 * Author: mharis001
 * Compiles a list of all Zeus placeable mines.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_modules_fnc_compileMines
 *
 * Public: No
 */
#include "script_component.hpp"

private _minesCache = [[], []];
_minesCache params ["_configNames", "_displayNames"];

{
    private _configName = configName _x;

    if (getNumber (_x >> "scopeCurator") == 2 && {_configName isKindOf "ModuleMine_F"} && {!(_configName isKindOf "ModuleExplosive_F")}) then {
        _configNames  pushBack _configName;
        _displayNames pushBack getText (_x >> "displayName");
    };
} forEach configProperties [configFile >> "CfgVehicles", "isClass _x"];

uiNamespace setVariable [QGVAR(minesCache), _minesCache];
