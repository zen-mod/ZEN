#include "script_component.hpp"
/*
 * Author: mharis001
 * Compiles a list of all flag textures.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_modules_fnc_compileFlags
 *
 * Public: No
 */

private _flagsCache = [[""], ["STR_A3_None"]];
_flagsCache params ["_flagTextures", "_displayNames"];

private _sortHelper = [];

{
    if (getNumber (_x >> "scope") == 2 && {configName _x isKindOf "FlagCarrier"}) then {
        private _initText = getText (_x >> "EventHandlers" >> "init");
        private _flagTexture = toLower (_initText splitString "'""" param [1, ""]);

        if (_flagTexture != "") then {
            // GetForcedFlagTexture returns texture without leading slash
            if (_flagTexture select [0, 1] == "\") then {
                _flagTexture = _flagTexture select [1];
            };

            _sortHelper pushBack [getText (_x >> "displayName"), _flagTexture];
        };
    };
} forEach configProperties [configFile >> "CfgVehicles", "isClass _x"];

_sortHelper sort true;

{
    _x params ["_displayName", "_flagTexture"];

    _flagTextures pushBack _flagTexture;
    _displayNames pushBack _displayName;
} forEach _sortHelper;

uiNamespace setVariable [QGVAR(flagsCache), _flagsCache];
