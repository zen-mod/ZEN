#include "script_component.hpp"
/*
 * Author: Ampersand
 * Unpacks a static weapon from units' backpacks.
 *
 * Arguments:
 * 0: Gunner <OBJECT>
 * 1: Assistant <OBJECT>
 * 2: Target Position <ARRAY>
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

if !(_targetPos isEqualTo []) then {
    _assistant doWatch _targetPos;
    _gunner setVariable [QGVAR(unpackStaticWeaponTargetPos), _targetPos];
};

_gunner addEventHandler ["WeaponAssembled", {
    params ["_gunner", "_weapon"];

    _gunner removeEventHandler ["WeaponAssembled", _thisEventHandler];

    private _targetPos = _gunner getVariable [QGVAR(unpackStaticWeaponTargetPos), []];
    if !(_targetPos isEqualTo []) then {
        _weapon setDir (_weapon getDir _targetPos);
        _gunner doWatch _targetPos;
    };

    // Added due to occassional tripod leg clipping through ground
    _weapon setPosASL (getPosASL _weapon vectorAdd [0,0,0.05]);
    _weapon setVectorUp surfaceNormal position _weapon;

    _gunner assignAsGunner _weapon;
    _gunner moveInGunner _weapon;

    _group = group _gunner;
    _group addVehicle _weapon;
}];

_gunner action ["PutBag", _assistant];
_gunner action ["Assemble", unitBackpack _assistant];
