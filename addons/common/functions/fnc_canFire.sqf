#include "script_component.hpp"
/*
 * Author: mharis001, Ampersand
 * Checks if the given unit can fire its weapon.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Ignore Ammo <BOOLEAN>
 *
 * Return Value:
 * Can Fire <BOOLEAN>
 *
 * Example:
 * [_unit] call zen_common_fnc_canFire
 *
 * Public: No
 */

params [["_unit", objNull], ["_ignoreAmmo", false]];

if (isNull _unit) exitWith {false};

// If a vehicle is given directly, use the first turret that can fire
if !(_unit isKindOf "CAManBase") exitWith {
    [[_unit] call FUNC(firstTurretUnit)] call FUNC(canFire);
};

alive _unit
&& {!isPlayer _unit}
&& {lifeState _unit in ["HEALTHY", "INJURED"]}
&& {
    private _vehicle = vehicle _unit;

    if (_vehicle == _unit || {_unit call FUNC(isUnitFFV)}) then {
        currentWeapon _unit != ""
        && {_ignoreAmmo || {
            _unit ammo currentMuzzle _unit > 0
        }}
    } else {
        private _turretPath = _vehicle unitTurret _unit;
        weaponState [_vehicle, _turretPath] params ["_weapon", "", "", "", "_ammo"];
        _weapon != ""
        && {!("Fake" in _weapon)}
        && {
            _ignoreAmmo
            || {_ammo > 0}
            || {"Horn" in _weapon}
        }
    }
}
