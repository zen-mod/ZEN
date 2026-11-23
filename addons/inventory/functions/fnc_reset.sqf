#include "script_component.hpp"
/*
 * Author: mharis001
 * Resets the cargo to the object's default config defined one.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_reset
 *
 * Public: No
 */

params ["_display"];

private _object = _display getVariable QGVAR(object);

// Set the cargo to the object's default inventory
private _cargo = _object call EFUNC(common,getDefaultInventory);

// Convert default weapons to weapon items arrays, keeping any config linked attachments
_cargo set [CARGO_WEAPONS, (_cargo select CARGO_WEAPONS) call FUNC(groupWeapons)];
_display setVariable [QGVAR(cargo), _cargo];

// Use config-defined contents for the default container items
private _containers = [];

{
    _x params ["_types", "_counts"];

    {
        if (_x isEqualType "" && {_x call EFUNC(common,isContainerItem)}) then {
            private _count = _counts select _forEachIndex;

            for "_i" from 1 to _count do {
                _containers pushBack [_x, []];
            };
        };
    } forEach _types;
} forEach _cargo;

_display setVariable [QGVAR(containers), _containers];

// Calculate the current load of the cargo
private _load = [_cargo] call FUNC(calculateLoad);
_display setVariable [QGVAR(currentLoad), _load];

// Refresh the list after resetting
_display call FUNC(refresh);
