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

if !(_changes isEqualTo []) then {
    {
    	_x params ["_turretPath", "_magazineClass", "_magazineCount"];
        private _turretOwner = _vehicle turretOwner _turretPath;

        if (_turretOwner == 0) then {
            [QEGVAR(common,setMagazineAmmo), [_vehicle, _turretPath, _magazineClass, _magazineCount], _vehicle] call CBA_fnc_targetEvent;
        } else {
            [QEGVAR(common,setMagazineAmmo), [_vehicle, _turretPath, _magazineClass, _magazineCount], _turretOwner] call CBA_fnc_ownerEvent;
        };
    } forEach _changes;
};
