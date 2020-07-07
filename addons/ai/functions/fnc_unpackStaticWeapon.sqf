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

if !(local _gunner) exitWith {
    [QGVAR(unpackStaticWeapon), _this, _gunner] call CBA_fnc_targetEvent;
};

_gunner setVariable [QGVAR(unpackStaticWeaponTargetPos), _targetPos];

// close enough, set up weapon
if (_gunner distance _assistant < 3) exitWith {
    [_pfID] call CBA_fnc_removePerFrameHandler;
    _gunner enableAI "PATH";
    private _g = group _gunner;
    [_assistant] joinSilent _g;
    _g setBehaviour (behaviour _gunner);
    _assistant enableAI "FSM";
    _canUnpack = true;

    _gunner addEventHandler ["WeaponAssembled", {
        params ["_gunner", "_weapon"];

        _gunner removeEventHandler ["WeaponAssembled", _thisEventHandler];

        private _targetPos = _gunner getVariable [QGVAR(unpackStaticWeaponTargetPos), []];
        if !(_targetPos isEqualTo []) then {
            _weapon setDir (_weapon getDir _targetPos);
            _gunner doWatch _targetPos;
        };

        _weapon setVectorUp surfaceNormal position _weapon;

        _gunner assignAsGunner _weapon;
        [_gunner] orderGetIn true;

        _group = group _gunner;
        _group addVehicle _weapon;
    }];

    private _weaponBase = unitBackpack _assistant;
    _gunner action ["PutBag", _assistant];
    _gunner action ["Assemble", _weaponBase];

    _assistant doWatch _targetPos;
};

// too far, order assistant to move to gunner and start pfh
private _startTime = CBA_MissionTime;
_gunner disableAI "PATH";
[_assistant] joinSilent grpNull;
private _g = (group _assistant);
_g setBehaviourStrong "CARELESS";
_g deleteGroupWhenEmpty true;
_g enableAttack false;
_assistant doMove getPos _gunner;
_assistant disableAI "FSM";
[{
    params ["_args", "_pfID"];
    _args params ["_gunner", "_assistant", "_mousePosASL", "_startTime"];

    if (CBA_MissionTime > (_startTime + 60) || {!alive _gunner || {!alive _assistant}}) exitWith {
        [_pfID] call CBA_fnc_removePerFrameHandler;
        _gunner enableAI "PATH";
        private _g = group _gunner;
        [_assistant] joinSilent _g;
        _g setBehaviour (behaviour _gunner);
        _assistant enableAI "FSM";
    };

    if (_gunner distance _assistant < 3) exitWith {
        [_pfID] call CBA_fnc_removePerFrameHandler;
        _gunner enableAI "PATH";
        private _g = group _gunner;
        [_assistant] joinSilent _g;
        _g setBehaviour (behaviour _gunner);
        _assistant enableAI "FSM";
        _canUnpack = true;

        _gunner addEventHandler ["WeaponAssembled", {
            params ["_gunner", "_weapon"];

            _gunner removeEventHandler ["WeaponAssembled", _thisEventHandler];

            private _targetPos = _gunner getVariable [QGVAR(unpackStaticWeaponTargetPos), []];
            if !(_targetPos isEqualTo []) then {
                _weapon setDir (_weapon getDir _targetPos);
                _gunner doWatch _targetPos;
            };

            _weapon setVectorUp surfaceNormal position _weapon;

            _gunner assignAsGunner _weapon;
            [_gunner] orderGetIn true;

            _group = group _gunner;
            _group addVehicle _weapon;
        }];

        private _weaponBase = unitBackpack _assistant;
        _gunner action ["PutBag", _assistant];
        _gunner action ["Assemble", _weaponBase];

        _assistant doWatch _targetPos;
    };

    if (unitReady _assistant || {CBA_MissionTime > (_startTime + 5)}) then {
        _assistant doMove getPos _gunner;
    };

}, 0.1, [_gunner, _assistant, _mousePosASL, _startTime]] call CBA_fnc_addPerFrameHandler;
