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
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, _weapon, _magazine, _delay, _dispersion, _target] call zen_modules_fnc_moduleTracers
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

// Create a new gunner and add the specified weapon and magazine to it
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

    if (CBA_missionTime >= _nextBurstTime && {allPlayers findIf {_gunner distance _x < 100} == -1}) then {
        private "_targetVector";

        if (_target isNotEqualTo objNull) then {
            // Set vector to target if one is specified
            if (_target isEqualType objNull) then {
                _target = getPosASLVisual _target;
            };

            // Randomize target vector based on dispersion
            _targetVector = getPosASLVisual _logic vectorFromTo _target;
            _targetVector = vectorNormalized (_targetVector vectorAdd [random _dispersion, random _dispersion, random _dispersion]);
            _logic setVectorDirAndUp [_targetVector, _targetVector vectorCrossProduct [-(_targetVector select 1), _targetVector select 0, 0]];
        } else {
            // No specific target, fire randomly in the air
            _gunner setDir random 360;
            [_gunner, 30 + random 60, 0] call BIS_fnc_setPitchBank;
        };

        private _burstLength = 0.1 + random 0.9;

        // Wait until gunner is on-target before starting burst
        [{
            params ["_logic", "_gunner", "_targetVector"];

            !alive _logic
            || {!alive _gunner}
            || {isNil "_targetVector"}
            || {vectorDirVisual _gunner vectorDotProduct _targetVector > 0.95}
        }, {
            params ["_logic", "_gunner", "", "_weapon", "_burstLength", "_startTime"];

            // Exit if aligning to target took too long
            private _timeout = _burstLength - (CBA_missionTime - _startTime);
            if (_timeout <= 0) exitWith {};

            [{
                params ["_logic", "_gunner", "_weapon", "_nextShotTime"];

                if (!alive _logic || {!alive _gunner}) exitWith {
                    true
                };

                if (CBA_missionTime >= _nextShotTime) then {
                    _gunner setAmmo [_weapon, 999];
                    [_gunner, _weapon] call BIS_fnc_fire;

                    private _shotDelay = 0.05 + random 0.1;
                    _this set [3, CBA_missionTime + _shotDelay];
                };

                false
            }, {}, [_logic, _gunner, _weapon, 0], _timeout] call CBA_fnc_waitUntilAndExecute;
        }, [_logic, _gunner, _targetVector, _weapon, _burstLength, CBA_missionTime], _burstLength] call CBA_fnc_waitUntilAndExecute;

        // Ensure a new burst is not started until this one finishes
        _args set [6, CBA_missionTime + (random _delay max _burstLength)];
    };
}, 0.1, [_logic, _gunner, _target, _weapon, _delay, _dispersion, 0]] call CBA_fnc_addPerFrameHandler;
