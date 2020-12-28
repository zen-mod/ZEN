#include "script_component.hpp"
/*
 * Author: Ampersand
 * Internal function to shoot tracers at a gamelogic's location.
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: Side <NUMBER> - Index of tracer colours [Green, Red, Yellow]
 * 2: Min <NUMBER> - Minimum delay in seconds between bursts
 * 3: Max <NUMBER> - Maximum delay in seconds between bursts
 * 4: Dispersion <NUMBER> - Index of dispersion values [0.001, 0.01, 0.05, 0.15, 0.3]
 * 5: Weapon <STRING> - CLassname of infantry weapon
 * 6: Magazine <STRING> - CLassname of infantry magazine
 * 7: Target <ARRAY, OBJECT, STRING> - Target object, position ASL, or string of target object variable name
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleTracers
 *
 * Public: No
 */

params [
    "_logic",
    ["_side", 0],
    ["_min", 10],
    ["_max", 20],
    ["_dispersion", 2],
    ["_weapon", ""],
    ["_magazine", ""],
    ["_target", objNull, [objNull, [], ""], 3]
];

_logic setVariable [QGVAR(tracersParams), [_side, _min, _max, _dispersion, _weapon, _magazine, _target], true];

_max = _max - _min;
_dispersion = [0.001, 0.01, 0.05, 0.15, 0.3] select _dispersion;

if (_weapon != "" ) then {
    // Validate weapon
    private _weaponCfg = configFile >> "CfgWeapons" >> _weapon;
    if (!isClass _weaponCfg)exitWith
    {
        if (_weapon != "") then {["'%1' not found in CfgWeapons", _weapon] call BIS_fnc_error;};
    };
    private _compatibileMagazine = [_weapon] call BIS_fnc_compatibleMagazines;
    // Automatically add first compatibile magazine
    if (_magazine == "") then {
        if (_compatibileMagazine isEqualTo []) exitWith {
            if (_weapon != "") then {["'%1' doesn't have any valid magazines", _weapon] call BIS_fnc_error;};
        };
        _magazine = _compatibileMagazine # 0;
    } else {
        // Validate magazine manually selected magazine
        if (! (_magazine in _compatibileMagazine) ) exitWith {
            if (_magazine != "") then {["'%1' is not compatible with '%2'", _magazine, _weapon] call BIS_fnc_error;};
        };
    };
} else {
    _weapon = "FakeWeapon_moduleTracers_F";
    _magazine = ["200Rnd_65x39_belt_Tracer_Green", "200Rnd_65x39_belt_Tracer_Red", "200Rnd_65x39_belt_Tracer_Yellow"] select _side;
};

private _gunner = _logic getVariable [QGVAR(tracersGunner), objNull];
deleteVehicle _gunner;
_gunner = createAgent ["B_Soldier_F", [0, 0, 0], [], 0, "NONE"];
_gunner attachTo [_logic, [0,0,0]];
_gunner setCaptive true;
_gunner hideObjectGlobal true;
_gunner allowDamage false;
_gunner switchMove "AmovPercMstpSrasWrflDnon";
_gunner disableAI "ANIM";
_gunner disableAI "MOVE";
_gunner disableAI "TARGET";
_gunner disableAI "AUTOTARGET";
_gunner setBehaviour "CARELESS";
_gunner setCombatMode "BLUE";
removeAllWeapons _gunner;
_gunner addMagazine _magazine;
_gunner addWeapon _weapon;
_gunner selectWeapon _weapon;
_logic setVariable [QGVAR(tracersGunner), _gunner, true];
_logic setVariable [QGVAR(nextBurstTime), 0];

[{
    params ["_args", "_pfhID"];
    _args params ["_logic", "_gunner", "_min", "_max", "_dispersion", "_weapon", "_target"];

    if (isNull _gunner || {isNull _logic}) exitWith {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
        deleteVehicle _gunner;
    };

    private _nextBurstTime = _logic getVariable [QGVAR(nextBurstTime), 0];
    if (
        CBA_MissionTime >= _nextBurstTime && {
            (playableunits + switchableunits) findIf {_gunner distance _x < 100} == -1
        }
    ) then {
        if (_target isEqualType "") then {
            _target = call compile _target;
        };
        if (isNil "_target") then {_target = objNull};

        private _vectorToTarget = [0, 0, 0];
        private _targetPos = [0, 0, 0];
        private _logicPos = getPosASLVisual _logic;
        private _dir = 0;
        private _pitch = 0;

        // Sets vector to the target if it's specified
        if (!(_target isEqualTo objNull)) then {
            // Refresh target
            if (_target isEqualType objNull) then {
                _targetPos = getPosASLVisual _target;
            } else {
                _targetPos = _target;
            };
            _vectorToTarget = _logicPos vectorFromTo _targetPos;

            // Vector randomization
            _vectorToTarget = _vectorToTarget vectorAdd [random [-_dispersion, 0, _dispersion], random [-_dispersion, 0, _dispersion], random [-_dispersion, 0, _dispersion]];
            _logic setVectorDirAndUp [_vectorToTarget, _vectorToTarget vectorCrossProduct [-(_vectorToTarget # 1), _vectorToTarget # 0, 0]];
        } else {
            // Random firing (old behavior)
            _dir = -5 + random 10;
            _pitch = 30 + random 60;
            _gunner setdir (random 360);
            [_gunner, _pitch, 0] call BIS_fnc_setpitchbank;
        };

        private _shotDelay = 0.05 + random 0.1;
        private _burstLength = 0.1 + random 0.9;

        [{
            params ["_nextShotTime", "_logic", "_gunner", "_dispersion", "_weapon", "_shotDelay"];

            // Aim
            if (!(_target isEqualTo objNull)) then {
                _vectorToTarget = _vectorToTarget vectorAdd [random [-_dispersion, 0, _dispersion], random [-_dispersion, 0, _dispersion], random [-_dispersion, 0, _dispersion]];
                _logic setVectorDirAndUp [_vectorToTarget, _vectorToTarget vectorCrossProduct [-(_vectorToTarget # 1), _vectorToTarget # 0, 0]];
            } else {
                _gunner setdir (direction _gunner + _dir);
                [_gunner, _pitch, 0] call BIS_fnc_setpitchbank;
            };

            // Fire
            if (CBA_MissionTime >= _nextShotTime) then {
                _gunner setAmmo [_weapon, 999];
                [_gunner, _weapon] call BIS_fnc_fire;
                _logic setVariable [QGVAR(nextShotTime), CBA_MissionTime + _shotDelay];
                _this set [0, CBA_missionTime + _shotDelay];
            };

        }, {}, [CBA_missionTime, _logic, _gunner, _dispersion, _weapon, _shotDelay], _burstLength] call CBA_fnc_waitUntilAndExecute;

        _nextBurstTime = CBA_MissionTime + (_min + random _max);
        _logic setVariable [QGVAR(nextBurstTime), _nextBurstTime];
    };
}, 0.1, [_logic, _gunner, _min, _max, _dispersion, _weapon, _target]] call CBA_fnc_addPerFrameHandler;
