#include "script_component.hpp"
/*
 * Author: Kex
 * Orders a VLS unit to commence fire burst on the given position (silently).
 *
 * Arguments:
 * 0: VLS unit <OBJECT>
 * 1: Target position <ARRAY>
 * 2: Spread <NUMBER>
 * 3: Magazine class <STRING>
 * 4: Number of rounds <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vlsUnit, getPos player, _magazine, 1] call zen_common_fnc_fireVLS;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_targetPosition", [0, 0, 0], [[]], 3], ["_spread", 0, [0]], ["_magazine", "", [""]], ["_rounds", 1, [0]]];

private _turretPath = [0];
private _muzzle = (_unit weaponsTurret _turretPath) param [0, ""];

private _eta = [_unit, _targetPosition, _magazine] call FUNC(getArtilleryETA);
private _reloadTime = [_unit, _muzzle, _turretPath] call FUNC(weaponReloadTime);

if (_unit currentMagazineTurret _turretPath != _magazine) then {
   [_unit, _turretPath, _muzzle, _magazine] call  FUNC(instantMagazineLoading);
};

_unit setVariable [QGVAR(roundCounter), 0];
[
    {
        params ["_args", "_handle"];
        _args params ["_unit", "_targetPosition", "_spread", "_muzzle", "_eta", "_reloadTime", "_rounds"];

        // VLS needs an actual dummy target to fire at
        _targetPosition = [_targetPosition, _spread] call CBA_fnc_randPos;
        private _target = (createGroup sideLogic) createUnit ["Module_F", _targetPosition, [], 0, "CAN_COLLIDE"];
        // +30% tolerance for possible underestimation of ETAs
        private _targetLifeTime = 1.3 * _eta + _reloadTime;
        (side _unit) reportRemoteTarget [_target, _targetLifeTime];
        [{deleteVehicle _this}, _target, _targetLifeTime] call CBA_fnc_waitAndExecute;

        _unit setWeaponReloadingTime [gunner _unit, _muzzle, 0];
        _unit fireAtTarget [_target, _muzzle];

        private _counter = _unit getVariable [QGVAR(roundCounter), _rounds];
        _counter = _counter + 1;
        if (_counter >= _rounds) then {
            // Clean-up
            _unit setVariable [QGVAR(roundCounter), nil];
            [_handle] call CBA_fnc_removePerFrameHandler;
        } else {
            _unit setVariable [QGVAR(roundCounter), _counter];
        };
    },
    _reloadTime,
    [_unit, _targetPosition, _spread, _muzzle, _eta, _reloadTime, _rounds]
] call CBA_fnc_addPerFrameHandler;
