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

#define DISTANCE_CLOSE 3
#define MOVE_DELAY 5
#define MOVE_TIMEOUT 60

params ["_gunner", "_assistant", ["_targetPos", [], [[]], 3]];

// Order assistant to move to gunner and start pfh
_gunner setVariable [QGVAR(statePATH), _gunner checkAIFeature "PATH"];
_gunner disableAI "PATH";
[_assistant] joinSilent grpNull;
private _group = group _assistant;
_group setBehaviourStrong "CARELESS";
_group deleteGroupWhenEmpty true;
_group enableAttack false;
_assistant doMove getPosATL _gunner;
_assistant setVariable [QGVAR(stateFSM), _assistant checkAIFeature "FSM"];
_assistant disableAI "FSM";
_assistant setVariable [QGVAR(nextMoveTime), CBA_MissionTime + 5];

[{
    params ["_args", "_pfhID"];
    _args params ["_gunner", "_assistant", "_targetPos", "_nextMoveTime", "_endTime"];

    private _closeEnough = _gunner distance _assistant <= DISTANCE_CLOSE;

    if (_closeEnough || {CBA_MissionTime > _endTime || {!alive _gunner || {!alive _assistant}}}) exitWith {
        [_pfhID] call CBA_fnc_removePerFrameHandler;

        // Gunner AI PATH
        if (_gunner getVariable [QGVAR(statePATH), true]) then {
            _gunner setVariable [QGVAR(statePATH), nil];
            _gunner enableAI "PATH";
        };

        // Reset assistant behaviour
        private _group = group _gunner;
        [_assistant] joinSilent _group;
        _group setBehaviour behaviour _gunner;

        // Assistant AI FSM
        if (_assistant getVariable [QGVAR(stateFSM), true]) then {
            _assistant setVariable [QGVAR(stateFSM), nil];
            _assistant enableAI "FSM";
        };
        // Close enough, unpack
        if (_closeEnough) then {
            [_gunner, _assistant, _targetPos] call FUNC(unpackStaticWeapon);
        };
    };

    if (unitReady _assistant || {CBA_MissionTime >= _nextMoveTime}) then {
        _assistant doMove ASLtoAGL getPosASL _gunner;
        _args set [3, CBA_missionTime + MOVE_DELAY];
    };
}, 0.1, [_gunner, _assistant, _targetPos, CBA_MissionTime + MOVE_DELAY, CBA_missionTime + MOVE_TIMEOUT]] call CBA_fnc_addPerFrameHandler;
