#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function create a tracers effect.
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: Weapon <STRING>
 * 2: Magazine <STRING>
 * 3: Burst Delay <ARRAY>
 * 4: Dispersion <NUMBER>
 * 5: Target <OBJECT|ARRAY>
 * 6: Vector To Target <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, _weapon, _magazine, _delay, _dispersion, _target, _vectorToTarget] call zen_modules_fnc_moduleTracers
 *
 * Public: No
 */

params ["_logic", "_weapon", "_magazine", "_delay", "_dispersion", "_target"];

// Broadcast tracer parameters so they available if the module is edited
_logic setVariable [QGVAR(tracersParams), [_weapon, _magazine, _delay, _dispersion, _target], true];

// Create random dispersion array from dispersion index
_dispersion = [0.001, 0.01, 0.05, 0.15, 0.3] select _dispersion;
_dispersion = [-_dispersion, 0, _dispersion];

// Delete any already created gunner
private _gunner = _logic getVariable [QGVAR(tracersGunner), objNull];
deleteVehicle _gunner;

_gunner = createAgent ["B_Soldier_F", [0, 0, 0], [], 0, "NONE"];
_gunner attachTo [_logic, [0, 0, 0]];
_gunner hideObjectGlobal true;
_gunner allowDamage false;
_gunner setCaptive true;
_gunner switchMove "AmovPercMstpSrasWrflDnon";
_gunner disableAI "ANIM";
_gunner disableAI "MOVE";
_gunner disableAI "TARGET";
_gunner disableAI "AUTOTARGET";
_gunner setBehaviour "CARELESS";
_gunner setCombatMode "BLUE";

_gunner setUnitLoadout (configFile >> "EmptyLoadout");
_gunner addWeapon _weapon;
_gunner selectWeapon _weapon;
_gunner addWeaponItem [_weapon, _magazine, true];

_logic setVariable [QGVAR(tracersGunner), _gunner];

[{
    params ["_args", "_pfhID"];
    _args params ["_logic", "_gunner", "_target", "_weapon", "_delay", "_dispersion", "_nextBurstTime"];

    if (!alive _logic || {!alive _gunner}) exitWith {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
        deleteVehicle _gunner;
    };

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
            _vectorToTarget = _vectorToTarget vectorAdd [random _dispersion, random _dispersion, random _dispersion];
            _logic setVectorDirAndUp [_vectorToTarget, _vectorToTarget vectorCrossProduct [-(_vectorToTarget # 1), _vectorToTarget # 0, 0]];
        } else {
            // Random firing (old behavior)
            _logic setdir (random 360);
            [_gunner, 30 + random 60, 0] call BIS_fnc_setPitchBank;
        };

        private _shotDelay = 0.05 + random 0.1;
        private _burstLength = 0.1 + random 0.9;

        [{
            params ["_args", "_delay"];
            _args params ["", "", "_gunner", "", "", "", "_vectorToTarget"];
            _vectorToTarget isEqualTo [0, 0, 0] || {
                // Wait until on-target before starting burst
                ((vectorDirVisual _gunner) vectorDotProduct (vectorNormalized _vectorToTarget)) > 0.99
            }
        }, {
            params ["_args", "_delay"];
            [{
                params ["_nextShotTime", "_logic", "_gunner", "_dispersion", "_weapon", "_shotDelay"];

                // Fire
                if (CBA_MissionTime >= _nextShotTime) then {
                    _gunner setAmmo [_weapon, 999];
                    [_gunner, _weapon] call BIS_fnc_fire;
                    //_logic setVariable [QGVAR(nextShotTime), CBA_MissionTime + _shotDelay];
                    _this set [0, CBA_missionTime + _shotDelay];
                };
            }, {}, _args, _delay] call CBA_fnc_waitUntilAndExecute;
        }, [[CBA_missionTime, _logic, _gunner, _dispersion, _weapon, _shotDelay, _vectorToTarget], _burstLength]] call CBA_fnc_waitUntilAndExecute;

        _args set [6, CBA_MissionTime + random _delay];
    };
}, 0.1, [_logic, _gunner, _target, _weapon, _delay, _dispersion, 0]] call CBA_fnc_addPerFrameHandler;
