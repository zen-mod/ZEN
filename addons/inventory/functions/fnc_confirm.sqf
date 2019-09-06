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

private _controlsGroup = ctrlParentControlsGroup _ctrlButtonOK;
private _object  = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _cargo   = _controlsGroup getVariable QEGVAR(attributes,value);

[_object, _cargo] call EFUNC(common,setInventory);
