#include "script_component.hpp"
/*
 * Author: Kex
 * Makes the given VLS unit fire on the given position.
 *
 * Arguments:
 * 0: VLS Unit <OBJECT>
 * 1: Target Position <ARRAY>
 * 2: Spread <NUMBER>
 * 3: Magazine Class <STRING>
 * 4: Number of Rounds <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, _position, 0, _magazine, 1] call zen_common_fnc_fireVLS
 *
 * Public: No
 */

#define GUNNER_TURRET [0]

// +30% tolerance for possible underestimation of ETAs
#define TARGET_LIFETIME_TOLERANCE 1.3

params [["_unit", objNull, [objNull]], ["_targetPosition", [0, 0, 0], [[]], 3], ["_spread", 0, [0]], ["_magazine", "", [""]], ["_rounds", 1, [0]]];

private _muzzle = (_unit weaponsTurret GUNNER_TURRET) param [0, ""];

private _eta = [_unit, _targetPosition, _magazine] call FUNC(getArtilleryETA);
private _reloadTime = [_unit, _muzzle, GUNNER_TURRET] call FUNC(getWeaponReloadTime);

// Load magazine even if it is the right one in order to ignore a possible reload occurring at the same time
[_unit, GUNNER_TURRET, _muzzle, _magazine] call FUNC(loadMagazineInstantly);

[{
    params ["_args", "_pfhID"];
    _args params ["_unit", "_targetPosition", "_spread", "_muzzle", "_eta", "_reloadTime", "_rounds", "_fired"];

    // VLS needs an actual dummy target to fire at
    _targetPosition = [_targetPosition, _spread] call CBA_fnc_randPos;
    private _logicGroup = createGroup [sideLogic, true];
    private _target = _logicGroup createUnit ["Module_F", _targetPosition, [], 0, "CAN_COLLIDE"];

    private _targetLifeTime = TARGET_LIFETIME_TOLERANCE * _eta + _reloadTime;
    (side _unit) reportRemoteTarget [_target, _targetLifeTime];
    [{deleteVehicle _this}, _target, _targetLifeTime] call CBA_fnc_waitAndExecute;

    _unit setWeaponReloadingTime [gunner _unit, _muzzle, 0];
    _unit fireAtTarget [_target, _muzzle];

    _fired = _fired + 1;

    if (_fired >= _rounds) then {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
    } else {
        _args set [7, _fired];
    };
}, _reloadTime, [_unit, _targetPosition, _spread, _muzzle, _eta, _reloadTime, _rounds, 0]] call CBA_fnc_addPerFrameHandler;
