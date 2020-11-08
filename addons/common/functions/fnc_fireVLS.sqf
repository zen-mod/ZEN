#include "script_component.hpp"
/*
 * Author: Kex
 * Makes the given VLS unit fire on the given position.
 *
 * Arguments:
 * 0: VLS Unit <OBJECT>
 * 1: Position <ARRAY|OBJECT|STRING>
 *   - in AGL format, or a Map Grid when STRING
 * 2: Spread <NUMBER>
 * 3: Magazine <STRING>
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

params [["_unit", objNull, [objNull]], ["_position", [0, 0, 0], [[], objNull, ""], 3], ["_spread", 0, [0]], ["_magazine", "", [""]], ["_rounds", 1, [0]]];

// If an object is given as the position, the dummy targets will be
// attached to this object in order to make the missile track the object
private _isObject = _position isEqualType objNull;

if (_position isEqualType "") then {
    _position = [_position, true] call CBA_fnc_mapGridToPos;
};

private _muzzle = (_unit weaponsTurret GUNNER_TURRET) param [0, ""];
private _reloadTime = [_unit, _muzzle, GUNNER_TURRET] call FUNC(getWeaponReloadTime);

// Load magazine even if it is the right one in order to ignore a possible reload occurring at the same time
[_unit, GUNNER_TURRET, _muzzle, _magazine] call FUNC(loadMagazineInstantly);

[{
    params ["_args", "_pfhID"];
    _args params ["_unit", "_isObject", "_position", "_spread", "_magazine", "_muzzle", "_reloadTime", "_rounds"];

    // Exit if target object is deleted
    if (_isObject && {isNull _position}) exitWith {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };

    // VLS needs a dummy target to fire at
    private _target = createGroup [sideLogic, true] createUnit ["Logic", _position, [], _spread, "CAN_COLLIDE"];

    if (_isObject) then {
        _target attachTo [_position];
    };

    // Delete the dummy target after enough time for the missile to reach the target has passed
    private _eta = [_unit, _target, _magazine] call FUNC(getArtilleryETA);
    private _lifetime = TARGET_LIFETIME_TOLERANCE * _eta + _reloadTime;
    [{deleteVehicle _this}, _target, _lifetime] call CBA_fnc_waitAndExecute;

    (side _unit) reportRemoteTarget [_target, _lifetime];
    _unit setWeaponReloadingTime [gunner _unit, _muzzle, 0];
    _unit fireAtTarget [_target, _muzzle];

    _rounds = _rounds - 1;
    _args set [7, _rounds];

    // Exit if the specified number of rounds have been fired
    if (_rounds <= 0) then {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };
}, _reloadTime, [_unit, _isObject, _position, _spread, _magazine, _muzzle, _reloadTime, _rounds]] call CBA_fnc_addPerFrameHandler;
