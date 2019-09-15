#include "script_component.hpp"
/*
 * Author: mharis001, NeilZar
 * Sets the ammo level of all magazines and pylons of a vehicle.
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

// Only run on server (turretOwner command requires server execution)
if (!isServer) exitWith {
    [QGVAR(setVehicleAmmo), _this] call CBA_fnc_serverEvent;
};

params ["_vehicle", "_percentage"];

// Set ammo for pylons with magazines, group pylons with the same
// magazine to better handle magazines with a low maximum ammo counts
private _pylonMagazines = getPylonMagazines _vehicle;
private _cfgMagazines = configFile >> "CfgMagazines";

{
    private _pylonMagazine = _x;

    if (_pylonMagazine != "") then {
        private _magazineCount = {_x == _pylonMagazine} count _pylonMagazines;
        private _maxRoundsPerMag = getNumber (_cfgMagazines >> _pylonMagazine >> "count");

        private _totalRounds = round (_magazineCount * _maxRoundsPerMag * _percentage);

        {
            if (_x == _pylonMagazine) then {
                private _roundsOnPylon = 0 max _totalRounds min _maxRoundsPerMag;
                _totalRounds = _totalRounds - _roundsOnPylon;

                [QGVAR(setAmmoOnPylon), [_vehicle, _forEachIndex + 1, _roundsOnPylon], _vehicle] call CBA_fnc_targetEvent;
            };
        } forEach _pylonMagazines;
    };
} forEach (_pylonMagazines arrayIntersect _pylonMagazines);

// Broadcast set turret ammo events to handle turret locality
{
    private _turretOwner = _vehicle turretOwner _x;

    if (_turretOwner == 0) then {
        [QGVAR(setTurretAmmo), [_vehicle, _x, _percentage], _vehicle] call CBA_fnc_targetEvent;
    } else {
        [QGVAR(setTurretAmmo), [_vehicle, _x, _percentage], _turretOwner] call CBA_fnc_ownerEvent;
    };
} forEach (_vehicle call FUNC(getAllTurrets));
