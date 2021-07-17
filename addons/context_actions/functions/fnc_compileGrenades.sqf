#include "script_component.hpp"
/*
 * Author: mharis001
 * Compiles a list of all throwable grenades.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_context_actions_fnc_compileGrenades
 *
 * Public: No
 */

GVAR(grenades) = [] call CBA_fnc_createNamespace;
GVAR(grenadesList) = []; // For fast filtering of non-grenade magazines

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

{
    private _muzzle = _x;

    {
        private _config = _cfgMagazines >> _x;
        private _displayName = getText (_config >> "displayName");
        private _picture = getText (_config >> "picture");

        GVAR(grenades) setVariable [_x, [_displayName, _picture, _x, _muzzle]];
        GVAR(grenadesList) pushBackUnique _x;
    } forEach getArray (_cfgWeapons >> "Throw" >> _muzzle >> "magazines");
} forEach getArray (_cfgWeapons >> "Throw" >> "muzzles");
