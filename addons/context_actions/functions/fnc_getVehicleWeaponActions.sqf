#include "script_component.hpp"
/*
 * Author: Ampersand
 * Returns children actions for switching between the given vehicle's weapons, muzzles, and magazines.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Actions <ARRAY>
 *
 * Example:
 * [_vehicle] call zen_context_actions_fnc_getVehicleWeaponActions
 *
 * Public: No
 */

#define AMMO_SIMULATION_BLACKLIST ["shotcm", "laserdesignate"]

params ["_vehicle"];

if !(_vehicle isEqualType objNull && {alive _vehicle}) exitWith {[]};

private _actions = [];
private _cfgAmmo = configFile >> "CfgAmmo";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgWeapons = configFile >> "CfgWeapons";

{
    private _turretPath = _x;
    private _turretMagazines = _vehicle magazinesTurret _turretPath;

    weaponState [_vehicle, _turretPath] params ["_currentWeapon", "_currentMuzzle", "", "_currentMagazine"];

    {
        private _weapon = _x;
        private _weaponConfig = _cfgWeapons >> _weapon;

        {
            private _muzzle = _x;
            private _muzzleConfig = _weaponConfig;

            if (_muzzle == "this") then {
                _muzzle = _weapon;
            } else {
                _muzzleConfig = _muzzleConfig >> _muzzle;
            };

            private _compatibleMagazines = [_muzzleConfig] call CBA_fnc_compatibleMagazines;
            private _magazines = _turretMagazines arrayIntersect _compatibleMagazines;

            {
                private _magazine = _x;
                private _magazineConfig = _cfgMagazines >> _magazine;

                // Skip current weapon, muzzle, and magazine combination
                if (
                    _weapon == _currentWeapon
                    && {_muzzle == _currentMuzzle}
                    && {_magazine == _currentMagazine}
                ) then {continue};

                // Skip blacklisted ammo simulation types
                private _ammoConfig = _cfgAmmo >> getText (_magazineConfig >> "ammo");
                private _ammoSimulation = toLower getText (_ammoConfig >> "simulation");
                if (_ammoSimulation in AMMO_SIMULATION_BLACKLIST) then {continue};

                private _name = format [
                    "%1 - %2 %3- %4",
                    [_vehicle, _turretPath] call EFUNC(common,getGunnerName),
                    getText (_weaponConfig >> "displayName"),
                    [format ["%1 ", _muzzle], ""] select (_muzzle == _weapon),
                    getText (_magazineConfig >> "displayName")
                ];

                private _icon = switch (_ammoSimulation) do {
                    case "shotbullet": {
                        "\a3\ui_f_jets\data\gui\cfg\hints\weaponsguns_ca.paa"
                    };
                    case "shotmissile": {
                        "\a3\ui_f_jets\data\gui\cfg\hints\weaponsmissiles_ca.paa"
                    };
                    case "shotilluminating": {
                        "\a3\ui_f\data\gui\cfg\hints\flares_ca.paa"
                    };
                    default {
                        QPATHTOF(ui\ammo_ca.paa)
                    };
                };

                private _action = [
                    [_weapon, _muzzle, _magazine] joinString "",
                    _name,
                    _icon,
                    {
                        _args call FUNC(switchVehicleWeapon)
                    },
                    {true},
                    [_vehicle, _turretPath, _weapon, _muzzle, _magazine]
                ] call EFUNC(context_menu,createAction);

                _actions pushBack [_action, [], 0];
            } forEach _magazines;
        } forEach getArray (_weaponConfig >> "muzzles");
    } forEach (_vehicle weaponsTurret _turretPath);
} forEach (_vehicle call EFUNC(common,getAllTurrets));

_actions
