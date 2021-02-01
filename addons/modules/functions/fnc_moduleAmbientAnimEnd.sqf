#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to end an ambient animation.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit] call zen_modules_fnc_moduleAmbientAnimEnd
 *
 * Public: No
 */

params ["_unit"];

// Remove added event handlers
private _animDoneEH = _unit getVariable [QGVAR(ambientAnimDoneEH), -1];
_unit removeEventHandler ["AnimDone", _animDoneEH];

private _killedEH = _unit getVariable [QGVAR(ambientAnimKilledEH), -1];
_unit removeMPEventHandler ["MPKilled", _killedEH];

private _firedNearEH = _unit getVariable [QGVAR(ambientAnimFiredNearEH), -1];
_unit removeEventHandler ["FiredNear", _firedNearEH];

// If unit is alive then re-enable AI intelligence and switch to previous animation
// If unit died, switch to the unit's death animation
if (alive _unit) then {
    [QEGVAR(common,enableAI), [_unit, ["ANIM", "AUTOTARGET", "FSM", "MOVE", "TARGET"]], _unit] call CBA_fnc_targetEvent;

    // Try playMoveNow first, use switchMove if animation does not respond
    private _previousAnim = _unit getVariable [QGVAR(ambientAnimStart), ""];
    [QEGVAR(common,playMoveNow), [_unit, _previousAnim]] call CBA_fnc_globalEvent;

    if (animationState _unit != _previousAnim) then {
        [QEGVAR(common,switchMove), [_unit, _previousAnim]] call CBA_fnc_globalEvent;
    };
} else {
    [QEGVAR(common,playMoveNow), [_unit, _unit call CBA_fnc_getUnitDeathAnim]] call CBA_fnc_globalEvent;
};

// Remove stored animations list and previous animation
_unit setVariable [QGVAR(ambientAnimList), nil];
_unit setVariable [QGVAR(ambientAnimStart), nil];
