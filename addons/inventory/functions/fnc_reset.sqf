#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles resetting the current inventory to the default config defined one.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_inventory_fnc_reset
 *
 * Public: No
 */

params ["_ctrlButtonReset"];

private _display = ctrlParent _ctrlButtonReset;
private _object = _display getVariable QGVAR(object);

// Reset the current inventory to the object's default inventory
private _cargo = _object call EFUNC(common,getDefaultInventory);
_display setVariable [QGVAR(cargo), _cargo];

// Recalculate the current load of the inventory
private _load = [_cargo] call FUNC(calculateLoad);
_display setVariable [QGVAR(currentLoad), _load];

// Update the load bar for the new load
[_display] call FUNC(updateLoadBar);

// Refresh the list after resetting
[_display] call FUNC(refreshList);
