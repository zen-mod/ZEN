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

private _grenades = createHashMap;
private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

{
    {
        private _config = _cfgMagazines >> _x;
        private _name = getText (_config >> "displayName");
        private _icon = getText (_config >> "picture");

        _grenades set [configName _config, [_name, _icon]];
    } forEach getArray (_cfgWeapons >> "Throw" >> _x >> "magazines");
} forEach getArray (_cfgWeapons >> "Throw" >> "muzzles");

uiNamespace setVariable [QGVAR(grenades), _grenades];
