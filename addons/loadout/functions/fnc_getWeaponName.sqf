#include "script_component.hpp"
/*
 * Author: NeilZar
 * Initializes the "Loadout" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_loadout_fnc_init
 *
 * Public: No
 */

params ["_object", "_weapon", "_turret"];

private _weaponName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
private _turretCopy = +_turret;
private _path = configFile >> "CfgVehicles" >> typeOf _object;

if !(_turretCopy isEqualTo [-1]) then {
    while {!(_turretCopy isEqualTo [])} do {
        _path = _path >> "Turrets";
        private _index = _turretCopy deleteAt 0;
        _path = (_path select _index);
    };
};

private _gunnerName = [_path >> "gunnerName", "STRING", "Pilot/Driver"] call CBA_fnc_getConfigEntry;

format ["%1 (%2)", _weaponName, _gunnerName];
