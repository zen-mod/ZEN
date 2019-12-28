#include "script_component.hpp"
/*
 * Author: Kex
 * Returns the ammo reloading time for a given weapon
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Muzzle class <STRING>
 * 2: Turret path <ARRAY>
 *
 * Return Value:
 * Reload time <NUMBER>
 *
 * Example:
 * [player, "arifle_MX_ACO_pointer_F"] call zen_common_fnc_fire;
 * [vehicle player, "HE", [0]] call zen_common_fnc_weaponReloadTime;
 *
 * Public: No
 */

params [["_entity", objNull, [objNull]], ["_muzzle", "", [""]], ["_turretPath", [], [[]]]];

// Get the weapon mode
private _state = [];
if (_entity isKindOf "CAManBase") then
{
    // Need to set the desired muzzle in order to get the correct fire mode
    private _currentMuzzle = (weaponState _entity) select 1;
    _entity selectWeapon _muzzle; 
    _state = weaponState _entity;
    // Restore the original muzzle
    _entity selectWeapon _currentMuzzle; 
}
else
{
    _state = weaponState [_entity, _turretPath, _muzzle];
};
_state params [["_weapon", ""], "", ["_mode", ""]];

// Get the muzzle config
private _muzzleCfg = configNull;
if (_muzzle == _weapon) then
{
    _muzzleCfg = (configFile >> "CfgWeapons" >> _weapon);
}
else
{
    _muzzleCfg = (configFile >> "CfgWeapons" >> _weapon >> _muzzle);
};

// Get the reload time
private _reloadTime = 0.1;
if (_mode == "this") then
{
    _reloadTime = getNumber (_muzzleCfg >> "reloadTime");
}
else
{
    _reloadTime = getNumber (_muzzleCfg >> _mode >> "reloadTime");
};

_reloadTime
