#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles confirming the inventory display changes.
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
private _object = _display getVariable QGVAR(object);
private _cargo  = _display getVariable QGVAR(cargo);
_cargo params ["_itemCargo", "_weaponCargo", "_magazineCargo", "_backpackCargo"];

clearItemCargoGlobal _object;
clearWeaponCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearBackpackCargoGlobal _object;

_itemCargo params ["_itemTypes", "_itemCounts"];

{
    _object addItemCargoGlobal [_x, _itemCounts select _forEachIndex];
} forEach _itemTypes;

_weaponCargo params ["_weaponTypes", "_weaponCounts"];

{
    _object addWeaponCargoGlobal [_x, _weaponCounts select _forEachIndex];
} forEach _weaponTypes;

_magazineCargo params ["_magazineTypes", "_magazineCounts"];

{
    _object addMagazineCargoGlobal [_x, _magazineCounts select _forEachIndex];
} forEach _magazineTypes;

_backpackCargo params ["_backpackTypes", "_backpackCounts"];

{
    _object addBackpackCargoGlobal [_x, _backpackCounts select _forEachIndex];
} forEach _backpackTypes;
