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
private _object  = GVAR(object);
private _cargo   = _display getVariable QGVAR(cargo);

[_object, _cargo] call EFUNC(common,setInventory);
