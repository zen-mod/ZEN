//#include "script_component.hpp"
/*
 * Author: Ampersand
 * Unpacks static weapon from units' backpacks.
 *
 * Arguments:
 * 0: Gunner <OBJECT>
 * 1: Assistant <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [gunner, assistant] call zen_modules_fnc_unpackStaticWeapon
 *
 * Public: No
 */

params ["_gunner", "_assistant", ["_targetPos", [], [[]], 3]];
if !(local _gunner) exitWith {_this remoteExecCall ["zen_ai_fnc_unpackStaticWeapon", _gunner]};

_gunner setVariable ["zen_ai_fnc_unpackStaticWeaponTargetPos", _targetPos];

_gunner addEventHandler ["WeaponAssembled", {
    params ["_gunner", "_weapon"];

    _gunner removeEventHandler ["WeaponAssembled", _thisEventHandler];

    _weapon setVectorUp surfaceNormal position _weapon;

    _gunner assignAsGunner _weapon;
    _gunner moveInGunner _weapon;

    private _targetPos = _gunner getVariable ["zen_ai_fnc_unpackStaticWeaponTargetPos", []];
    if !(_targetPos isEqualTo []) then {
        _weapon setDir (_weapon getDir _targetPos);
        _gunner doWatch _targetPos;
    };

    _group = group _gunner;
    _group addVehicle _weapon;
}];

_weaponBase = unitBackpack _assistant;
_gunner action ["PutBag", _assistant];
_gunner action ["Assemble", _weaponBase];

if !(_targetPos isEqualTo []) then {
    _assistant doWatch _targetPos;
};
