#include "script_component.hpp"
/*
 * Author: Ampersand
 * Dynamically creates child actions to select weapon for turrets with multiple weapons/muzzles/magazines.
 *
 * Arguments:
 * 0: None <OBJECT>
 * 1: None <OBJECT>
 * 2: None <OBJECT>
 * 3: None <OBJECT>
 * 4: None <OBJECT>
 * 5: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call zen_context_actions_fnc_getVehicleWeaponActions
 *
 * Public: No
 */

_vehicle = _this select 5;

private _cfgAmmo = configFile >> "CfgAmmo";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgWeapons = configFile >> "CfgWeapons";

private _currentWeapon = currentWeapon _vehicle;
private _currentWeaponMuzzles = getArray (_cfgWeapons >> _currentWeapon >> "muzzles");
private _currentMagazine = currentMagazine _vehicle;

private _primaryGunner = gunner _vehicle;
private _primaryTurret = [0];
if (isNull _primaryGunner) then {
    _primaryGunner = driver _vehicle;
    _primaryTurret = [-1];
};
if (isNull _primaryGunner) exitWith {};

private _currentMuzzle = currentMuzzle _primaryGunner;

private _uniqueList = [];
private _dynamicChildren = [];

{
    _x params ["_magazine", "_turretPath", "_count", "_id", "_owner"];
    if (_turretPath isEqualTo _primaryTurret && {_count > 0}) then {
        private _ammo = getText (_cfgMagazines >> _magazine >> "ammo");
        private _ammoSimulation = getText (_cfgAmmo >> _ammo >> "simulation");
        if !(_ammoSimulation in ["shotCM", "laserDesignate"]) then {
            {
                private _weapon = _x;
                {
                    private _muzzle = _x;
                    private _compatibleMagazines = [_cfgWeapons >> _weapon >> _muzzle, true] call CBA_fnc_compatibleMagazines;
                    if (_compatibleMagazines isEqualTo []) then {
                        _compatibleMagazines = [_weapon] call CBA_fnc_compatibleMagazines;
                    };
                    if (_magazine in _compatibleMagazines) then {
                        if !([_weapon, _muzzle, _magazine] in _uniqueList) then  {
                            _uniqueList pushBack [_weapon, _muzzle, _magazine];
                            if !(_weapon == _currentWeapon && {_magazine == _currentMagazine && {_muzzle == _currentMuzzle || {_muzzle == "this"}}}) then {
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
                                        "P:\a3\ui_f_jets\Data\GUI\Cfg\Hints\WeaponsMissiles_ca.paa"
                                    };
                                    case ("shotIlluminating"): {
                                        "C:\PDrive\a3\ui_f\data\GUI\Cfg\Hints\Flares_CA.paa"
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
                            };
                        };
                    };
                } forEach getArray (_cfgWeapons >> _weapon >> "muzzles");
            } forEach (_vehicle weaponsTurret _turretPath);
        };
    };
} forEach magazinesAllTurrets _vehicle;

_dynamicChildren
