#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles confirming the specified pylon loadout.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_pylons_fnc_handleConfirm
 *
 * Public: No
 */

params ["_ctrlButtonOK"];

private _display = ctrlParent _ctrlButtonOK;
private _aircraft = _display getVariable QGVAR(aircraft);

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

// Keep track of default pylon weapons to keep for each turret
private _driverWeapons = [];
private _gunnerWeapons = [];

// Get pylon loadout from combo boxes and turret buttons
private _pylonLoadout = [];

{
    _x params ["_ctrlCombo", "_ctrlTurret"];

    private _magazine = _ctrlCombo lbData lbCurSel _ctrlCombo;
    private _turretPath = _ctrlTurret getVariable [QGVAR(turretPath), [-1]];

    private _pylonWeapon = configName (_cfgWeapons >> getText (_cfgMagazines >> _magazine >> "pylonWeapon"));

    if (_turretPath isEqualTo [-1]) then {
        _driverWeapons pushBackUnique _pylonWeapon;
    } else {
        _gunnerWeapons pushBackUnique _pylonWeapon;
    };

    _pylonLoadout pushBack [_magazine, _turretPath];
} forEach (_display getVariable QGVAR(controls));

[QGVAR(setLoadout), [_aircraft, _pylonLoadout], _aircraft] call CBA_fnc_targetEvent;

// Get all compatible default pylon weapons for the aircraft
// These are added automatically if a compatible weapon for the magazine
// does not exist when using the setPylonLoadout command
private _pylonWeapons = [];

{
    _pylonWeapons append (_x apply {
        configName (_cfgWeapons >> getText (_cfgMagazines >> _x >> "pylonWeapon"))
    });
} forEach (_aircraft getCompatiblePylonMagazines 0);

_pylonWeapons = _pylonWeapons arrayIntersect _pylonWeapons;

// Remove default pylons weapons that will no longer be used
// Prevents weapons with no magazines from showing up when cycling through weapons
// This will also handle rare situations where a compatible weapon that is not a
// default pylon weapon was already present on the turret
{
    _x params ["_weaponsToKeep", "_turretPath"];

    private _weaponsToRemove = _aircraft weaponsTurret _turretPath select {
        !(_x in _weaponsToKeep) && {_x in _pylonWeapons}
    };

    if (_weaponsToRemove isNotEqualTo []) then {
        [QGVAR(removeWeapons), [_aircraft, _turretPath, _weaponsToRemove], _aircraft, _turretPath] call CBA_fnc_turretEvent;
    };
} forEach [
    [_driverWeapons, [-1]],
    [_gunnerWeapons, [0]]
];
