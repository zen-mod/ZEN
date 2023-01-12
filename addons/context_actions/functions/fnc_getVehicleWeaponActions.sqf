#include "script_component.hpp"
/*
 * Author: Ampersand
 * Dynamically creates child actions for a vehicle to switch between multiple weapons/muzzles/magazines.
 *
 * Arguments from CfgContext insertChildren:
 * 0: None
 * 1: None
 * 2: None
 * 3: None
 * 4: None
 * 5: Vehicle <OBJECT>
 *
 * Return Value:
 * 0: Child Actions <ARRAY>
 *
 * Example:
 * ["", "", "", "", "", _vehicle] call zen_context_actions_fnc_getVehicleWeaponActions
 *
 * Public: No
 */

params ["", "", "", "", "", "_vehicle"];

if !(_vehicle isEqualType objNull && {alive _vehicle}) exitWith {[]};

private _primaryGunner = gunner _vehicle;
private _primaryTurret = [0];

if (isNull _primaryGunner) then {
    _primaryGunner = driver _vehicle;
    _primaryTurret = [-1];
};

if (isNull _primaryGunner || {!alive _primaryGunner}) exitWith {[]};

private _cfgAmmo = configFile >> "CfgAmmo";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgWeapons = configFile >> "CfgWeapons";

private _currentWeapon = currentWeapon _vehicle;
private _currentMagazine = currentMagazine _vehicle;

private _currentMuzzle = currentMuzzle _primaryGunner;

private _uniqueList = []; // Unique combination of [_weapon, _muzzle, _magazine]
private _dynamicChildren = [];

{ // Loop magazinesAllTurrets _vehicle
    _x params ["_magazine", "_turretPath", "_count", "_id", "_owner"]; // LoadMagazine action needs id and owner

    // Magazines should be in priamry turret, have ammo
    if (_turretPath isNotEqualTo _primaryTurret || {_count < 1}) then { continue; };

    private _ammo = getText (_cfgMagazines >> _magazine >> "ammo");
    private _ammoSimulation = getText (_cfgAmmo >> _ammo >> "simulation");

    if (_ammoSimulation in AMMO_SIMULATION_BLACKLIST) then { continue; };

    { // Loop weapons in primary turret
        private _weapon = _x;

        { // Loop muzzles of weapon
            private _muzzle = _x;
            private _compatibleMagazines = [_cfgWeapons >> _weapon >> _muzzle, true] call CBA_fnc_compatibleMagazines;
            if (_compatibleMagazines isEqualTo []) then {
                _compatibleMagazines = [_weapon] call CBA_fnc_compatibleMagazines;
            };

            if (
                !(_magazine in _compatibleMagazines) // Incompatible
                || {[_weapon, _muzzle, _magazine] in _uniqueList} // Already added
                || { // Currently selected weapon/muzzle/magazine
                    _weapon == _currentWeapon
                    && {_magazine == _currentMagazine}
                    && {_muzzle == _currentMuzzle || {_muzzle == "this"}}
                }
            ) then { continue; };

            _uniqueList pushBack [_weapon, _muzzle, _magazine];
            private _actionPath = format ["%1%2%3", _weapon, _muzzle, _magazine];
            private _name = format [
                "%1 %2- %3",
                getText(_cfgWeapons >> _weapon >> "displayName"),
                [format ["%1 ", _muzzle], ""] select (_muzzle == "this"),
                getText(_cfgMagazines >> _magazine >> "displayName")
            ];

            private _icon = switch (_ammoSimulation) do {
                case ("shotBullet"): {
                    "\a3\ui_f_jets\Data\GUI\Cfg\Hints\WeaponsGuns_ca.paa"
                };

                case ("shotMissile"): {
                    "\a3\ui_f_jets\data\gui\cfg\hints\weaponsmissiles_ca.paa"
                };

                case ("shotIlluminating"): {
                    "\a3\ui_f\data\gui\cfg\hints\flares_ca.paa"
                };

                default {
                    QPATHTOF(ui\ammo_ca.paa)
                };
            };

            private _statement = {_args call FUNC(selectVehicleWeapon)};
            private _action = [
                _actionPath,
                _name,
                _icon,
                _statement,
                {true},
                [_vehicle, _primaryGunner, _primaryTurret, _weapon, _muzzle, _magazine, _id, _owner]
            ] call EFUNC(context_menu,createAction);
            _dynamicChildren pushBack [_action, [], 0];
        } forEach getArray (_cfgWeapons >> _weapon >> "muzzles");
    } forEach (_vehicle weaponsTurret _turretPath);
} forEach magazinesAllTurrets _vehicle;

_dynamicChildren
