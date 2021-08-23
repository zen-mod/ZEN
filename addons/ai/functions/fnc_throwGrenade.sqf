#include "script_component.hpp"
/*
 * Author: mharis001
 * Makes the unit throw a grenade at the given position.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Grenade Magazine <STRING>
 * 2: Position ASL <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, "HandGrenade", [0, 0, 0]] call zen_ai_fnc_throwGrenade
 *
 * Public: No
 */

#define AIMING_TIMEOUT 10
#define INITIAL_DELAY 0.5
#define CLEANUP_DELAY 1.5

#define TOLERANCE_TIME 2
#define MIN_TOLERANCE 10
#define MAX_TOLERANCE 45

#define DISABLED_ABILITIES ["AIMINGERROR", "AUTOTARGET", "FSM", "PATH", "SUPPRESSION", "TARGET"]

params [
    ["_unit", objNull, [objNull]],
    ["_magazine", "", [""]],
    ["_position", [0, 0, 0], [[]], 3]
];

if (!local _unit) exitWith {
    [QGVAR(throwGrenade), _this, _unit] call CBA_fnc_targetEvent;
};

// Exit if the unit cannot throw the given grenade type
if !([_unit, _magazine] call FUNC(canThrowGrenade)) exitWith {};

// Disable AI abilities to make units more responsive to commands
// Also interrupts a unit's movement to a waypoint, forcing them to stop
private _abilities = DISABLED_ABILITIES apply {_unit checkAIFeature _x};
{_unit disableAI _x} forEach DISABLED_ABILITIES;

// Set the unit's behaviour to COMBAT to make them raise their weapon and aim at the target
private _behaviour = combatBehaviour _unit;
_unit setCombatBehaviour "COMBAT";

// Set the unit's combat mode to BLUE to make them hold their fire
// The unit will still track the target but only fire when told to
private _combatMode = unitCombatMode _unit;
_unit setUnitCombatMode "BLUE";

// Prevent the unit from changing stance due to combat behaviour by
// forcing a unit position that matches their current stance
// Usually only a problem with the AUTO unit position
private _unitPos = unitPos _unit;
private _stanceIndex = ["STAND", "CROUCH", "PRONE"] find stance _unit;
private _unitPosForStance = ["UP", "MIDDLE", "DOWN"] param [_stanceIndex, "UP"];
_unit setUnitPos _unitPosForStance;

// Create a helper object for the unit to target
private _helper = createVehicle ["CBA_B_InvisibleTargetVehicle", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_helper setPosASL _position;

// Make the unit target the helper object
_unit reveal [_helper, 4];
_unit lookAt _helper;
_unit doWatch _helper;
_unit doTarget _helper;

// Wait until the unit is aiming at the helper object before throwing the grenade
// Initial delay helps prevent weird issue when the unit is moving to a waypoint and the helper is directly in front of it
[{
    _this set [7, CBA_missionTime];

    [{
        params ["_unit", "_helper", "_magazine", "_abilities", "_behaviour", "_combatMode", "_unitPos", "_startTime"];

        // Check that the unit is aiming at the helper, increase tolerance as more time passes
        private _direction = _unit getRelDir _helper;
        private _tolerance = linearConversion [0, TOLERANCE_TIME, CBA_missionTime - _startTime, MIN_TOLERANCE, MAX_TOLERANCE, true];
        private _throwGrenade = _direction <= _tolerance || {_direction >= 360 - _tolerance};

        if (_throwGrenade) then {
            private _index = magazines _unit find _magazine;

            if (_index != -1) then {
                private _magazine = magazinesDetail _unit select _index;
                _magazine call EFUNC(common,parseMagazineDetail) params ["_id", "_owner"];
                CBA_logic action ["UseMagazine", _unit, _unit, _owner, _id];
            };
        };

        if (
            _throwGrenade
            || {!alive _unit}
            || {isNull _helper}
            || {CBA_missionTime >= _startTime + AIMING_TIMEOUT}
        ) exitWith {
            // Restore AI abilities, behaviour, combat mode, stance, and targeting
            // Small delay before cleanup to give the unit time to finish throwing the grenade
            [{
                params ["_unit", "_helper", "_abilities", "_behaviour", "_combatMode", "_unitPos"];

                {
                    if (_x) then {
                        _unit enableAI (DISABLED_ABILITIES select _forEachIndex);
                    };
                } forEach _abilities;

                _unit setCombatBehaviour _behaviour;
                _unit setUnitCombatMode _combatMode;
                _unit setUnitPos _unitPos;
                _unit doWatch objNull;
                _unit lookAt objNull;

                deleteVehicle _helper;
            }, [_unit, _helper, _abilities, _behaviour, _combatMode, _unitPos], CLEANUP_DELAY] call CBA_fnc_waitAndExecute;

            true // Exit
        };

        false // Continue
    }, {}, _this] call CBA_fnc_waitUntilAndExecute;
}, [_unit, _helper, _magazine, _abilities, _behaviour, _combatMode, _unitPos], INITIAL_DELAY] call CBA_fnc_waitAndExecute;
