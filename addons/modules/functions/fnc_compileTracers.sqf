#include "script_component.hpp"
/*
 * Author: Ampersand, mharis001
 * Compiles a list of weapons that have compatible tracer magazines.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_modules_fnc_compileTracers
 *
 * Public: No
 */

private _tracersCache = createHashMap;
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgMagazineWells = configFile >> "CfgMagazineWells";

{
    if (
        getNumber (_x >> "scope") == 2
        && {getNumber (_x >> "type") == TYPE_WEAPON_PRIMARY}
        && {count getArray (_x >> "muzzles") == 1}
    ) then {
        private _weapon = configName _x;

        if (getText (_x >> "baseWeapon") == _weapon) then {
            private _magazines = getArray (_x >> "magazines");

            {
                {
                    _magazines insert [-1, getArray _x, true];
                } forEach configProperties [_cfgMagazineWells >> _x, "isArray _x", false];
            } forEach getArray (_x >> "magazineWell");

            private _tracerMagazines = _magazines select {
                getNumber (_cfgMagazines >> _x >> "tracersEvery") == 1
            } apply {
                configName (_cfgMagazines >> _x)
            };

            if (_tracerMagazines isNotEqualTo []) then {
                _tracersCache set [_weapon, _tracerMagazines];
            };
        };
    };
} forEach configProperties [configFile >> "CfgWeapons", "isClass _x"];

uiNamespace setVariable [QGVAR(tracersCache), _tracersCache];
