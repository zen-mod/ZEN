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
_display setVariable [QGVAR(cargo), _cargo];

// Calculate the current load of the cargo
private _load = [_cargo] call FUNC(calculateLoad);
_display setVariable [QGVAR(currentLoad), _load];

// Refresh the list after resetting
_display call FUNC(refresh);
