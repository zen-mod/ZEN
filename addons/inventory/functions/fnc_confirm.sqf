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

clearItemCargoGlobal _object;
clearWeaponCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearBackpackCargoGlobal _object;

private _cargo = _display getVariable QGVAR(cargo);
_cargo params ["_itemCargo", "_weaponCargo", "_magazineCargo", "_backpackCargo"];

ADD_CARGO(_object,addItemCargoGlobal,_itemCargo);
ADD_CARGO(_object,addWeaponCargoGlobal,_weaponCargo);
ADD_CARGO(_object,addMagazineCargoGlobal,_magazineCargo);
ADD_CARGO(_object,addBackpackCargoGlobal,_backpackCargo);
