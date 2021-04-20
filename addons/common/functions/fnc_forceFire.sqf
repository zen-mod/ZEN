#include "script_component.hpp"
/*
 * Author: Ampersand
 * Makes the given artillery unit fire on the given position.
 *
 * Arguments:
 * 0: Artillery Unit <OBJECT>
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
 * [_unit, _position, 0, _magazine, 1] call zen_common_fnc_forceFire
 *
 * Public: No
 */

params ["_curatorClientID", "_shooters"];
_shooters = _shooters select {
    local _x
    && {alive _x}
    && {!isNull _x}
    // Is vehicle, on foot, or in a turret
    && {_x == vehicle _x || {_x call cba_fnc_turretPath isNotEqualTo []}}
};

if (_shooters isEqualTo []) exitWith {
    GVAR(forceFireCurators) = GVAR(forceFireCurators) - [_curatorClientID];
};

// Track which curators are forcing fire on local machine
GVAR(forceFireCurators) pushBackUnique _curatorClientID;

// Repeating fire for local shooters
[{
    params ["_args", "_pfhID"];
    _args params ["_curatorClientID", "_shooters", "_endTime"];

    if (!(_curatorClientID in GVAR(forceFireCurators)) || {CBA_missionTime > _endTime}) exitWith {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };

    {
        private _shooter = _x;
        private _vehicle = vehicle _shooter;

        // Find shooter unit in vehicle
        if !(_shooter isKindOf "CAManBase") then {
            _shooter = [gunner _vehicle, driver _vehicle] select (isNull gunner _vehicle);
        };

        if (
            !isNull _shooter
            && {CBA_missionTime > (_shooter getVariable [QGVAR(nextForceFireTime), 0])}
        ) then {
            if (_vehicle == _shooter) then {
                // On foot
                weaponState _shooter params ["", "_muzzle", "_firemode"];
                _shooter forceWeaponFire [_muzzle, _firemode];
            } else {
                (fullCrew _vehicle select {_x select 0 == _shooter} select 0) params ["", "", "_cargoIndex", "_turretPath", "_isFFV"];
                // FFV
                if (_isFFV) exitWith {
                    weaponState _shooter params ["", "_muzzle", "_firemode"];
                    _shooter forceWeaponFire [_muzzle, _firemode];
                };
                // Vehicle crew
                if (driver _vehicle == _shooter) then {
                    // Horn
                    weaponState [_vehicle, [-1]] params ["_weapon", "_muzzle", "_firemode"];
                    _shooter forceWeaponFire [_muzzle, _firemode];
                } else {
                    private _turretPath = _shooter call CBA_fnc_turretPath;
                    weaponState [_vehicle, _turretPath] params ["_weapon", "", "", "_magazine", "_ammo"];
                    private _reloadTime = getNumber (configFile >> "CfgWeapons" >> _weapon >> "reloadTime");
                    if (_reloadTime < 0.5) then {_reloadTime = 0};
                    {
                        _x params ["_xMagazine", "_xTurret", "_xAmmo", "_id", "_owner"];
                        if (_xTurret isEqualTo _turretPath && {_xMagazine == _magazine && {_xAmmo == _ammo && {_xAmmo != 0}}}) exitWith {
                            _vehicle action ["UseMagazine", _vehicle, _shooter, _owner, _id];
                            _shooter setVariable [QGVAR(nextForceFireTime), CBA_missionTime + _reloadTime];
                        };
                    } forEach magazinesAllTurrets _vehicle;
                };
            };
        };
    } forEach _shooters;
}, 0.1, [_curatorClientID, _shooters, CBA_missionTime + 10]] call CBA_fnc_addPerFrameHandler;
