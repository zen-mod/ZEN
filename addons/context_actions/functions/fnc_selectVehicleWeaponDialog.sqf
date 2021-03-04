#include "script_component.hpp"
/*
 * Author: Ampersand
 * Opens dialog to select a weapon for turrets with multiple weapons/muzzles/magazines.
 * Triggered by the Vehicle Logistics > Switch Weapons parent action.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call zen_context_actions_fnc_selectVehicleWeaponDialog
 *
 * Public: No
 */

params ["_vehicle"];

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
private _results = [];
private _labels = [];
private _currentIndex = 0;

{
    _x params ["_magazine", "_turretPath", "_count", "_id", "_owner"];
    if (_turretPath isEqualTo _primaryTurret && {_count > 0}) then {
        private _ammo = getText (_cfgMagazines >> _magazine >> "ammo");
        private _ammoSimulation = getText (_cfgAmmo >> _ammo >> "simulation");
        if !(_ammoSimulation in AMMO_SIMULATION_BLACKLIST) then {
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
                            if (_weapon == _currentWeapon && {_magazine == _currentMagazine && {_muzzle == _currentMuzzle || {_muzzle == "this"}}}) then {
                                _currentIndex = count _uniqueList;
                            };
                            _uniqueList pushBack [_weapon, _muzzle, _magazine];
                            _results pushBack [_weapon, _muzzle, _magazine, _id, _owner];
                            private _weaponName = getText(_cfgWeapons >> _weapon >> "displayName");
                            _labels pushBack format [
                                "%1 %2- %3",
                                _weaponName,
                                [format ["%1 ", _muzzle], ""] select (_muzzle == "this"),
                                getText(_cfgMagazines >> _magazine >> "displayName")
                            ];
                        };
                    };
                } forEach getArray (_cfgWeapons >> _weapon >> "muzzles");
            } forEach (_vehicle weaponsTurret _turretPath);
        };
    };
} forEach magazinesAllTurrets _vehicle;

["STR_A3_Switch1", [
    [
        "LIST",
        "STR_A3_Switch1",
        [_results, _labels, _currentIndex, count _uniqueList],
        true
    ]
], {
    params ["_dialogValues", "_args"];
    _dialogValues params ["_result"];
    _result params ["_weapon", "_muzzle", "_magazine", "_id", "_owner"];
    _args params ["_vehicle", "_primaryGunner", "_primaryTurret"];
    weaponState [_vehicle, _primaryTurret] params ["_currentWeapon", "_currentMuzzle", "", "_currentMagazine"];

    if (_muzzle == "this") then {
        _muzzle = _weapon;
    };
    if (_currentWeapon != _weapon || {_currentMuzzle != _muzzle}) then {
        [QEGVAR(common,selectWeapon),  [_vehicle,  _muzzle],  _vehicle] call CBA_fnc_targetEvent;
    };
    if (_currentMagazine != _magazine) then {
        [QEGVAR(common,action), [_primaryGunner, ["LoadMagazine", _vehicle, _primaryGunner, _owner, _id, _weapon, _muzzle]], _primaryGunner] call CBA_fnc_targetEvent;
    };
}, {}, [_vehicle, _primaryGunner, _primaryTurret]] call EFUNC(dialog,create);
