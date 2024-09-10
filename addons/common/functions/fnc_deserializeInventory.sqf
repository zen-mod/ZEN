#include "script_component.hpp"
/*
 * Author: mharis001
 * Applies the serialized inventory data to the given object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Serialized Inventory <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, _inventory] call zen_common_fnc_deserializeInventory
 *
 * Public: No
 */

params ["_object", "_inventory"];
_inventory params ["_items", "_weapons", "_magazines", "_backpacks", "_containers"];

clearItemCargoGlobal _object;
clearWeaponCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearBackpackCargoGlobal _object;

_items params ["_itemTypes", "_itemCounts"];

{
    _object addItemCargoGlobal [_x, _itemCounts select _forEachIndex];
} forEach _itemTypes;

{
    _object addWeaponWithAttachmentsCargoGlobal [_x, 1];
} forEach _weapons;

// BWC for magazines format returned by the getMagazineCargo command
if (count _magazines == 2 && {_magazines select 0 isEqualTo [] || {_magazines select 0 isEqualTypeAll ""}}) then {
    _magazines params ["_magazineTypes", "_magazineCounts"];

    {
        _object addMagazineCargoGlobal [_x, _magazineCounts select _forEachIndex];
    } forEach _magazineTypes;
} else {
    {
        _x params ["_magazine", "_ammoCount"];

        _object addMagazineAmmoCargo [_magazine, 1, _ammoCount];
    } forEach _magazines;
};

_backpacks params ["_backpackTypes", "_backpackCounts"];

{
    _object addBackpackCargoGlobal [_x, _backpackCounts select _forEachIndex];
} forEach _backpackTypes;

// Handle containers inside the object's inventory
private _allContainers = everyContainer _object;

{
    _x params ["_type", "_inventory"];

    private _index = _allContainers findIf {_x select 0 == _type};
    private _container = _allContainers deleteAt _index select 1;

    [_container, _inventory] call FUNC(deserializeInventory);
} forEach _containers;
