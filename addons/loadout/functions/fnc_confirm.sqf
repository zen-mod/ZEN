#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles confirming the inventory attribute changes.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_inventory_fnc_confirm
 *
 * Public: No
 */

params ["_ctrlButtonOK"];

private _display = ctrlParent _ctrlButtonOK;
private _vehicle = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _changes = _display getVariable QGVAR(changes);
private _cfgMagazines = configFile >> "CfgMagazines";

if !(_changes isEqualTo []) then {
    {
    	_x params ["_turretPath", "_magazineClass", "_magazineCount"];
        private _turretOwner = _vehicle turretOwner _turretPath;
        private _magazineAmmo = getNumber (_cfgMagazines >> _magazineClass >> "count");

        if (_turretOwner == 0) then {
            [QGVAR(setMagazineAmmo), [_vehicle, [_magazineClass, _turretPath, _magazineAmmo, _magazineCount], 1], _vehicle] call CBA_fnc_targetEvent;
        } else {
            [QGVAR(setMagazineAmmo), [_vehicle, [_magazineClass, _turretPath, _magazineAmmo, _magazineCount], 1], _turretOwner] call CBA_fnc_ownerEvent;
        };
    } forEach _changes;
};
