#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the DLC that the given config belongs to.
 *
 * Arguments:
 * 0: Config <CONFIG>
 *
 * Return Value:
 * DLC <STRING>
 *
 * Example:
 * [configFile >> "CfgVehicles" >> "CAManBase"] call zen_common_fnc_getDLC
 *
 * Public: No
 */

params [["_config", configNull, [configNull]]];

private _dlc = "";
private _addons = configSourceAddonList _config;

if !(_addons isEqualTo []) then {
    private _mods = configSourceModList (configFile >> "CfgPatches" >> _addons select 0);

    if !(_mods isEqualTo []) then {
        _dlc = _mods select 0;
    };
};

_dlc
