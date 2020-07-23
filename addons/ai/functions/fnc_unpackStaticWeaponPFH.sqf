#include "script_component.hpp"
/*
 * Author: Ampersand
 * Move units together if needed and unpacks a static weapon from units' backpacks.
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
 * [_gunner, _assistant] call zen_ai_fnc_unpackStaticWeaponPFH
 *
 * Public: No
 */

params ["_gunner", "_assistant", ["_targetPos", [], [[]], 3]];

if !(local _gunner) exitWith {
    [QGVAR(unpackStaticWeapon), _this, _gunner] call CBA_fnc_targetEvent;
};

_gunner setVariable [QGVAR(unpackStaticWeaponTargetPos), _targetPos];

// Close enough, set up weapon
if (_gunner distance _assistant < 3) exitWith {
    [_gunner, _assistant] call FUNC(unpackStaticWeapon);
};

// Too far, order assistant to move to gunner and start pfh
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
    _args params ["_gunner", "_assistant", "_startTime"];

    private _closeEnough = _gunner distance _assistant < 3;
    private _elapsedtime = CBA_MissionTime - _startTime;

    if (_closeEnough || {_elapsedtime > 60 || {!alive _gunner || {!alive _assistant}}}) exitWith {
        [_pfID] call CBA_fnc_removePerFrameHandler;
        _gunner enableAI "PATH";
        // Reset assistant behaviour
        private _g = group _gunner;
        [_assistant] joinSilent _g;
        _g setBehaviour (behaviour _gunner);
        _assistant enableAI "FSM";

        if (_closeEnough) then {
            [_gunner, _assistant] call FUNC(unpackStaticWeapon);
        };
    };

    if (unitReady _assistant || {_elapsedtime % 5 < 0.1}) then {
        _assistant doMove getPos _gunner;
    };

}, 0.1, [_gunner, _assistant, CBA_MissionTime]] call CBA_fnc_addPerFrameHandler;
