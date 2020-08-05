#include "script_component.hpp"
#define DISTANCE_CLOSE 3
#define MOVE_DELAY 0.1
#define MOVE_TIMEOUT 60
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

if (!local _gunner) exitWith {
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
private _group = group _assistant;
_group setBehaviourStrong "CARELESS";
_group deleteGroupWhenEmpty true;
_group enableAttack false;
_assistant doMove getPosATL _gunner;
_assistant disableAI "FSM";
_assistant setVariable [QGVAR(nextMoveTime), CBA_MissionTime + 5];

[{
    params ["_args", "_pfhID"];
    _args params ["_gunner", "_assistant", "_startTime"];

    private _closeEnough = _gunner distance _assistant < DISTANCE_CLOSE;
    private _endTime = _startTime + MOVE_TIMEOUT;

    if (_closeEnough || {CBA_MissionTime > _endTime || {!alive _gunner || {!alive _assistant}}}) exitWith {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
        _gunner enableAI "PATH";
        // Reset assistant behaviour
        private _group = group _gunner;
        [_assistant] joinSilent _group;
        _group setBehaviour (behaviour _gunner);
        _assistant enableAI "FSM";

        if (_closeEnough) then {
            [_gunner, _assistant] call FUNC(unpackStaticWeapon);
        };
    };

    private _nextMoveTime = _assistant getVariable [QGVAR(nextMoveTime), CBA_MissionTime];
    if (unitReady _assistant || {CBA_MissionTime > _nextMoveTime}) then {
        _assistant setVariable [QGVAR(nextMoveTime), CBA_MissionTime + 5];
        _assistant doMove ASLtoAGL getPosASL _gunner;
    };
}, MOVE_DELAY, [_gunner, _assistant, CBA_MissionTime]] call CBA_fnc_addPerFrameHandler;
