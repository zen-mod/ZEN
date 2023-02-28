#include "script_component.hpp"
/*
 * Author: mharis001
 * Makes the given unit or group perform suppressive fire on the target
 * for the specified amount of time.
 *
 * Arguments:
 * 0: Unit or Group <OBJECT|GROUP>
 * 1: Target <OBJECT|ARRAY>
 *   - Position must be in ATL format.
 * 2: Duration <NUMBER> (default: 20)
 * 3: Fire Mode <NUMBER> (default: 4)
 *   - 0: Single shots (slow).
 *   - 1: Single shots (fast).
 *   - 2: Three round bursts (slow).
 *   - 3: Three round bursts (fast).
 *   - 4: Fully automatic (with pauses).
 *   - 5: Fully automatic (uninterrupted).
 *   - May not apply to weapons limited by long ammo reloading times.
 * 4: Stance <STRING> (default: "AUTO")
 *   - Must be one of the modes used by the setUnitPos command.
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, _target, 20, "MIDDLE"] call zen_ai_fnc_suppressiveFire
 *
 * Public: No
 */

#define TARGETING_DELAY 3
#define DISABLED_ABILITIES ["AIMINGERROR", "AUTOTARGET", "FSM", "PATH", "SUPPRESSION", "TARGET"]

params [
    ["_unit", objNull, [objNull, grpNull]],
    ["_target", [0, 0, 0], [[], objNull], 3],
    ["_duration", 20, [0]],
    ["_fireMode", 4, [0]],
    ["_stance", "AUTO", [""]]
];

if (!local _unit) exitWith {
    [QGVAR(suppressiveFire), _this, _unit] call CBA_fnc_targetEvent;
};

if (_unit isEqualType grpNull) exitWith {
    {
        [_x, _target, _duration, _fireMode, _stance] call FUNC(suppressiveFire);
    } forEach units _unit;
};

// If a vehicle is given directly, use its gunner as the unit
if !(_unit isKindOf "CAManBase") then {
    _unit = gunner _unit;
};

if !([_unit, true] call EFUNC(common,canFire)) exitWith {};
if (_unit getVariable [QGVAR(isSuppressing), false]) exitWith {};

// Prevent the unit from performing other suppressive fire tasks while this one is active
_unit setVariable [QGVAR(isSuppressing), true, true];

// Disable AI abilities to make units more responsive to commands
private _abilities = DISABLED_ABILITIES apply {_unit checkAIFeature _x};
{_unit disableAI _x} forEach DISABLED_ABILITIES;

// Without maximum skill, AI do not reliably target objects at long range
// This does make them very accurate at close range but this is not a big issue
private _skills = AI_SUB_SKILLS apply {_unit skill _x};
_unit setSkill 1;

// Set the unit's behaviour to COMBAT to make them raise their weapon and aim at the target
private _behaviour = combatBehaviour _unit;
_unit setCombatBehaviour "COMBAT";

// Set the unit's combat mode to BLUE to make them hold their fire
// The unit will still track the target but only fire when told to
private _combatMode = unitCombatMode _unit;
_unit setUnitCombatMode "BLUE";

// Apply the specified stance
private _unitPos = unitPos _unit;
_unit setUnitPos _stance;

// Create a temporary target object if one is not given (needed for the doTarget command)
private _isTempTarget = _target isEqualType [];

if (_isTempTarget) then {
    // Using Logic or Module_F doesn't work well. At best, AI will loosely target those objects
    // However, they will realiably and accurately target this object type
    _target = createVehicle ["CBA_B_InvisibleTargetVehicle", _target, [], 0, "CAN_COLLIDE"];
};

// Make the unit aim and track the target
_unit reveal [_target, 4];
_unit lookAt _target;
_unit doWatch _target;
_unit doTarget _target;

// Get the rounds per burst and time between bursts based on the given fire mode
[
    [1, [2, 3, 4]],
    [1, [1, 1.5, 2]],
    [3, [2, 3, 4]],
    [3, [1, 1.5, 2]],
    [10, [1.25, 1.5, 1.75]],
    [10, [0, 0, 0]]
] select (0 max _fireMode min 5) params ["_roundsPerBurst", "_burstDelay"];

// Force the unit to fire their weapon for the specified duration. Works better than using the doSuppressiveFire
// command which does not make units realiably fire at the target, especially at longer distances. Small initial
// delay to give units time to aim at the target. We ignore reloading and give units infinite ammo to create a
// more convincing suppressive fire effect
private _endTime = CBA_missionTime + _duration + TARGETING_DELAY;

[{
    [{
        params [
            "_unit",
            "_target",
            "_isTempTarget",
            "_abilities",
            "_skills",
            "_behaviour",
            "_combatMode",
            "_unitPos",
            "_roundsPerBurst",
            "_burstDelay",
            "_currentBurstRounds",
            "_shotTime",
            "_endTime"
        ];

        if (
            !alive _unit
            || {isNull _target}
            || {CBA_missionTime >= _endTime}
        ) exitWith {
            // Delete temporary target object
            if (_isTempTarget) then {
                deleteVehicle _target;
            };

            // Restore AI abilities, skills, behaviour, combat mode, stance, and targeting
            {
                if (_x) then {
                    _unit enableAI (DISABLED_ABILITIES select _forEachIndex);
                };
            } forEach _abilities;

            {
                _unit setSkill [AI_SUB_SKILLS select _forEachIndex, _x];
            } forEach _skills;

            _unit setVariable [QGVAR(isSuppressing), nil, true];
            _unit setCombatBehaviour _behaviour;
            _unit setUnitCombatMode _combatMode;
            _unit setUnitPos _unitPos;
            _unit doWatch objNull;
            _unit lookAt objNull;

            true // Exit
        };

        if (CBA_missionTime >= _shotTime) then {
            [_unit, true] call EFUNC(common,forceFire);

            private _vehicle = vehicle _unit;
            private _turretPath = _vehicle unitTurret _unit;

            // Set time until the next shot based on the weapon's ammo reloading time and whether the current burst is finished
            private _reloadTime = [_vehicle, _turretPath] call EFUNC(common,getWeaponReloadTime);
            _currentBurstRounds = _currentBurstRounds + 1;

            if (_currentBurstRounds >= _roundsPerBurst) then {
                _currentBurstRounds = 0;

                // Calculate the delay until the next burst
                // Use ammo reloading time if it is longer to prevent firing before the weapon is ready
                private _nextBurstDelay = random _burstDelay max _reloadTime;
                _shotTime = CBA_missionTime + _nextBurstDelay;
            } else {
                _shotTime = CBA_missionTime + _reloadTime;
            };

            _this set [10, _currentBurstRounds];
            _this set [11, _shotTime];
        };

        false // Continue
    }, {}, _this] call CBA_fnc_waitUntilAndExecute;
}, [
    _unit,
    _target,
    _isTempTarget,
    _abilities,
    _skills,
    _behaviour,
    _combatMode,
    _unitPos,
    _roundsPerBurst,
    _burstDelay,
    0, // _currentBurstRounds
    0, // _shotTime
    _endTime
], TARGETING_DELAY] call CBA_fnc_waitAndExecute;
