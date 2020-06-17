#include "script_component.hpp"
/*
 * Author: Ampersand
 * Unpacks a static weapon from units' backpacks.
 *
 * Arguments:
 * 0: Gunner <OBJECT>
 * 1: Assistant <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_gunner, _assistant] call zen_ai_fnc_unpackStaticWeapon
 *
 * Public: No
 */

params ["_gunner", "_assistant", ["_targetPos", [], [[]], 3]];
//if !(local _gunner) exitWith {_this remoteExecCall [FUNC(unpackStaticWeapon), _gunner]};
if !(local _gunner) exitWith {
    [QGVAR(unpackStaticWeapon), _this, _gunner] call CBA_fnc_targetEvent;
};

_gunner setVariable [QGVAR(unpackStaticWeaponTargetPos), _targetPos];

_gunner addEventHandler ["WeaponAssembled", {
    params ["_gunner", "_weapon"];

    _gunner removeEventHandler ["WeaponAssembled", _thisEventHandler];

    _weapon setVectorUp surfaceNormal position _weapon;

    _gunner assignAsGunner _weapon;
    _gunner moveInGunner _weapon;

    private _targetPos = _gunner getVariable [QGVAR(unpackStaticWeaponTargetPos), []];
    if !(_targetPos isEqualTo []) then {
        _weapon setDir (_weapon getDir _targetPos);
        _gunner doWatch _targetPos;
    };

    _group = group _gunner;
    _group addVehicle _weapon;
}];

private _weaponBase = unitBackpack _assistant;
_gunner action ["PutBag", _assistant];
_gunner action ["Assemble", _weaponBase];

if !(_targetPos isEqualTo []) then {
    _assistant doWatch _targetPos;
};
