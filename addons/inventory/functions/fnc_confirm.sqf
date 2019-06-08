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
#include "script_component.hpp"

params ["_ctrlButtonOK"];

private _display = ctrlParent _ctrlButtonOK;
private _object  = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _cargo   = _display getVariable QGVAR(cargo);

[_object, _cargo] call EFUNC(common,setInventory);
