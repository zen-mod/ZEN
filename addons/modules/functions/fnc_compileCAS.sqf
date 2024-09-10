#include "script_component.hpp"
/*
 * Author: mharis001
 * Compiles a list of all planes available for CAS.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_modules_fnc_compileCAS
 *
 * Public: No
 */

private _casCache = [[], [], [], []];

{
    private _configName = configName _x;

    if (getNumber (_x >> "scope") == 2 && {_configName isKindOf "Plane"}) then {
        private _allWeapons = _configName call BIS_fnc_weaponsEntityType;

        {
            private _types   = _x;
            private _weapons = _allWeapons select {toLower ((_x call BIS_fnc_itemType) select 1) in _types};

            if (_weapons isNotEqualTo []) then {
                _casCache select _forEachIndex pushBack [_configName, _weapons];
            };
        } forEach CAS_WEAPON_TYPES;
    };
} forEach configProperties [configFile >> "CfgVehicles", "isClass _x"];

uiNamespace setVariable [QGVAR(casCache), _casCache];
