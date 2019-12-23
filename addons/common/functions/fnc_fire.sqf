#include "script_component.hpp"
/*
 * Author: Kex
 * Wrapper for BIS_fnc_fire for supporting any magazines.
 *
 * Arguments:
 * 0: Entity <OBJECT>
 * 1: Muzzle and magazine <ARRAY>
 * 2: Turret path <ARRAY>
 * 3: Number of rounds <NUMBER>
 * 4: Current round <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, ["arifle_MX_ACO_pointer_F", "30Rnd_65x39_caseless_mag"], 20] call zen_common_fnc_fire;
 * [vehicle player, ["HE", "60Rnd_40mm_GPR_Tracer_Red_shells"], [0], 10] call zen_common_fnc_fire;
 *
 * Public: No
 */

params [["_entity", objNull, [objNull]], ["_weaponData", [], [[]]], ["_turretPath", [], [[]]], ["_numberOfRounds", 1, [0]], ["_currentRound", 0, [0]]];
_weaponData params [["_muzzle", "", [""]], ["_magazine", "", [""]]];

// Handle initialization
if (_currentRound == 0) then {
    // Get current magazine if _magazine is not specified
    private _currentMagazine = _magazine;
    if (_magazine != "") then {
        if (_entity isKindOf "CAManBase") then {
            _currentMagazine = currentMagazine _entity;
        } else {
            _currentMagazine = _entity currentMagazineTurret _turretPath;
        };
    };

    // Instant magazine reload
    if (_currentMagazine != _magazine) then {
        private _magazines = _entity magazinesTurret _turretPath;
        private _magIdx = _magazines findIf {_x == _magazine};
        if (_magIdx >= 0) then {
            private _magazinesUnique = _magazines arrayIntersect _magazines;
            private _ammoArray = _magazinesUnique apply {_entity magazineTurretAmmo [_x, _turretPath]};

            // Remove weapon and magazines
            { 
                _entity removeMagazinesTurret [_x, _turretPath] 
            } forEach _magazinesUnique;
            _entity removeWeaponTurret [_muzzle, _turretPath];

            // Add desired magazine first
            _entity addMagazineTurret [_magazines select _magIdx, _turretPath];
            _magazines deleteAt _magIdx;

            // Restore weapon and magazines
            _entity addWeaponTurret [_muzzle, _turretPath];
            { 
                _entity addMagazineTurret [_x, _turretPath];
            } forEach _magazines;
            { 
                _entity setMagazineTurretAmmo [_magazinesUnique select _forEachIndex, _x, _turretPath];
            } forEach _ammoArray;
        };
    };
};

// Fire until _numberOfRounds is satisfied
if (_currentRound < _numberOfRounds) then {
    _currentRound = _currentRound + 1;
    [_entity, _muzzle, _turretPath] call BIS_fnc_fire;
    private _reloadTime = [_muzzle] call FUNC(weaponReloadTime);
    [_fnc_scriptName, [_entity, _weaponData, _turretPath, _numberOfRounds, _currentRound], _reloadTime] call CBA_fnc_waitAndExecute;
};
