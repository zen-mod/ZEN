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
private _pylonMags = getPylonMagazines _vehicle;
private _turretMags = magazinesAllTurrets _vehicle select {
    _x params ["_magazineClass"];
    !(_className in _pylonMags || {_className in BLACKLIST_MAGAZINES})
};

private _countPylons = count _pylonMags;
private _cfgMagazines  = configFile >> "CfgMagazines";

{
    private _pylonMagazine = _x;

    if (_pylonMagazine != "") then {
        private _maxRoundsPerMag = getNumber (_cfgMagazines >> _pylonMagazine >> "count");
        private _magazineCount = _countPylons - count (_pylonMags - [_pylonMagazine]);

        private _totalRounds = round (_magazineCount * _maxRoundsPerMag * _percentage);

        {
            if (_x == _pylonMagazine) then {
                private _roundsOnPylon = 0 max _totalRounds min _maxRoundsPerMag;
                _totalRounds = _totalRounds - _roundsOnPylon;

                [QGVAR(setAmmoOnPylon), [_vehicle, _forEachIndex + 1, _roundsOnPylon], _vehicle] call CBA_fnc_targetEvent;
            };
        } forEach _pylonMags;
    };
} forEach (_pylonMags arrayIntersect _pylonMags);

// Iterate through each magazine type in each turret and add required information for zen_common_fnc_setMagazineAmmo
private _turretMagsCount = (_turretMags apply {[_x select 0, _x select 1]}) call CBA_fnc_getArrayElements;

_turretMags = _turretMagsCount select {_x isEqualType []};
_turretMagsCount = _turretMagsCount select {_x isEqualType 0};

// Iterate through all magazines in the turrets and broadcast events to handle turret locality
{
	_x params ["_name", "_turretPath"];
    private _turretOwner = _vehicle turretOwner _turretPath;
    _x append [getNumber (_cfgMagazines >> _name >> "count"), _turretMagsCount select _forEachIndex];

    if (_turretOwner == 0) then {
        [QGVAR(setMagazineAmmo), [_vehicle, _x, _percentage], _vehicle] call CBA_fnc_targetEvent;
    } else {
        [QGVAR(setMagazineAmmo), [_vehicle, _x, _percentage], _turretOwner] call CBA_fnc_ownerEvent;
    };
} forEach _turretMags;
