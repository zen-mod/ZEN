/*
 * Author: mharis001
 * Sets the ammo level of all turrets and pylons of a vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Ammo Level <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, 1] call zen_common_fnc_setVehicleAmmo
 *
 * Public: No
 */
#include "script_component.hpp"

// Only run on server (turretOwner command requires server execution)
if (!isServer) exitWith {
    [QGVAR(setVehicleAmmo), _this] call CBA_fnc_serverEvent;
};

params ["_vehicle", "_percentage"];

// Set ammo for pylons with magazines, group pylons with the same
// magazine to better handle magazines with a low maximum ammo counts
private _currentPylons = getPylonMagazines _vehicle;
private _countPylons   = count _currentPylons;
private _cfgMagazines  = configFile >> "CfgMagazines";

{
    private _pylonMagazine = _x;

    if (_pylonMagazine != "") then {
        private _maxRoundsPerMag = getNumber (_cfgMagazines >> _pylonMagazine >> "count");
        private _magazineCount = _countPylons - count (_currentPylons - [_pylonMagazine]);

        private _totalRounds = round (_magazineCount * _maxRoundsPerMag * _percentage);

        {
            if (_x == _pylonMagazine) then {
                private _roundsOnPylon = 0 max _totalRounds min _maxRoundsPerMag;
                _totalRounds = _totalRounds - _roundsOnPylon;

                [QGVAR(setAmmoOnPylon), [_vehicle, _forEachIndex + 1, _roundsOnPylon], _vehicle] call CBA_fnc_targetEvent;
            };
        } forEach _currentPylons;
    };
} forEach (_currentPylons arrayIntersect _currentPylons);

// Iterate through all turrets and broadcast events to handle turret locality
{
    private _turretPath  = _x;
    private _turretOwner = _vehicle turretOwner _turretPath;

    if (_turretOwner == 0) then {
        [QGVAR(setTurretAmmo), [_vehicle, _turretPath, _percentage], _vehicle] call CBA_fnc_targetEvent;
    } else {
        [QGVAR(setTurretAmmo), [_vehicle, _turretPath, _percentage], _turretOwner] call CBA_fnc_ownerEvent;
    };
} forEach (_vehicle call FUNC(getAllTurrets));
