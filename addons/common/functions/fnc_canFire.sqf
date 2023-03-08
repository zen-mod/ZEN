#include "script_component.hpp"
/*
 * Author: mharis001, Ampersand
 * Checks if the given unit or vehicle can fire its current weapon.
 *
 * Arguments:
 * 0: Unit or Vehicle <OBJECT>
 * 1: Ignore Ammo <BOOL> (default: false)
 * 2: Ignore Reload <BOOL> (default: false)
 *
 * Return Value:
 * Can Fire <BOOL>
 *
 * Example:
 * [_unit] call zen_common_fnc_canFire
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_ignoreAmmo", false, [false]], ["_ignoreReload", false, [false]]];

private _unit = _unit call FUNC(getEffectiveGunner);

alive _unit
&& {!isPlayer _unit}
&& {lifeState _unit in ["HEALTHY", "INJURED"]}
&& {
    private _vehicle = vehicle _unit;

    if (_vehicle == _unit || {_unit call FUNC(isUnitFFV)}) then {
        currentWeapon _unit != ""
        && {_ignoreAmmo || {_unit ammo currentMuzzle _unit > 0}}
        && {_ignoreReload || {!(_unit call FUNC(isReloading))}}
    } else {
        private _turretPath = _vehicle unitTurret _unit;
        weaponState [_vehicle, _turretPath] params ["_weapon", "", "", "", "_ammoCount"];

        _weapon != ""
        && {!("fake" in toLower _weapon)}
        && {_ignoreAmmo || {_ammoCount > 0} || {_weapon isKindOf ["CarHorn", configFile >> "CfgWeapons"]}}
        && {_ignoreReload || {!([_vehicle, _turretPath] call FUNC(isReloading))}}
    };
}
