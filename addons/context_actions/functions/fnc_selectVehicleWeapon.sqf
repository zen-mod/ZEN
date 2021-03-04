#include "script_component.hpp"
/*
 * Author: Ampersand
 * Makes a vehicle's primary turret use a weapon/muzzle/magazine.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Gunner <OBJECT>
 * 2: Turret Path <ARRAY>
 * 3: Weapon Class <STRING>
 * 4: Muzzle Class <STRING>
 * 5: Magazine Class <STRING>
 * 6: Magazine ID <NUMBER>
 * 7: Owner <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call zen_context_actions_fnc_selectVehicleWeapon
 *
 * Public: No
 */

params ["_vehicle", "_primaryGunner", "_primaryTurret", "_weapon", "_muzzle", "_magazine", "_id", "_owner"];

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
