#include "script_component.hpp"
/*
 * Author: mharis001, Venrix
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
private _cargo = _display getVariable QGVAR(cargo);
_cargo params ["_itemCargo", "_weaponCargo", "_magazineCargo", "_backpackCargo"];

// Preserve original nested container contents that survived editor operations
private _preservedContainers = _display getVariable QGVAR(containers) apply {
    _x params ["_type", "_container"];

    [
        _type,
        if (isNull _container) then {
            // Needed to properly handle newly added containers with config defined inventories
            // Otherwise, their contents would be cleared and never added back
            // This ensures that their inventories remain untouched
            []
        } else {
            _container call EFUNC(common,serializeInventory)
        }
    ]
};

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

// Restore preserved contents into the re-added containers, matching (and consuming) by class
private _everyContainer = everyContainer _object;

{
    _x params ["_type", "_data"];

    private _index = _everyContainer findIf {_x select 0 == _type};

    if (_index != -1) then {
        private _container = _everyContainer deleteAt _index select 1;

        // Consume new containers too so duplicate classes remain aligned,
        // but don't restore anything into them
        if (_data isNotEqualTo []) then {
            [_container, _data] call EFUNC(common,deserializeInventory);
        };
    };
} forEach _preservedContainers;
