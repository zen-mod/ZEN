#include "script_component.hpp"
/*
 * Author: NeilZar
 * Handles confirming the loadout display changes.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_loadout_fnc_confirm
 *
 * Public: No
 */

params ["_ctrlButtonOK"];

private _display = ctrlParent _ctrlButtonOK;
private _vehicle = _display getVariable QGVAR(vehicle);
private _changes = _display getVariable QGVAR(changes);

{
    _x params ["_turretPath", "_magazineClass", "_magazineCount"];
    [QEGVAR(common,setMagazineAmmo), [_vehicle, _turretPath, _magazineClass, _magazineCount], _vehicle, _turretPath] call CBA_fnc_turretEvent;
} forEach _changes;
