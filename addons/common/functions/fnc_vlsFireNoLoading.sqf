/*
 * Author: Kex
 *
 * Orders a unit to commence fire burst on the given position (silently).
 * Won't work if required magazine is not loaded.
 *
 * Arguments:
 * 0: VLS unit <OBJECT>
 * 1: Target position <ARRAY>
 * 2: Magazine class <STRING>
 * 3: Number of rounds <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vlsUnit, getPos player, magazineClass, 1] call zen_common_fnc_vlsFireNoLoading
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_targetPosition", "_magazineClass", "_rounds"];

// VLS needs an actual dummy target to fire at
private _target = (createGroup sideLogic) createUnit ["Module_F", _targetPosition, [], 0, "CAN_COLLIDE"];

_unit setVariable [QGVAR(roundCounter), 0];
[
    {
        params ["_args", "_handle"];
        _args params ["_unit", "_target", "_weaponClass", "_rounds"];

        _unit setWeaponReloadingTime [gunner _unit, _weaponClass, 0];
        _unit fireAtTarget [_target];

        private _counter = _unit getVariable [QGVAR(roundCounter), _rounds];
        _counter = _counter + 1;
        if (_counter >= _rounds) then {
            _unit setVariable [QGVAR(roundCounter), nil];
            [_handle] call CBA_fnc_removePerFrameHandler;

            deleteVehicle _target;
        } else {
            _unit setVariable [QGVAR(roundCounter), _counter];
        };
    },
    _reloadTime,
    [_unit, _target, _weaponClass, _rounds]
] call CBA_fnc_addPerFrameHandler;
