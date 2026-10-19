#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles a unit getting in or out of a vehicle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Role (not used) <STRING>
 * 2: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, "driver", _vehicle] call zen_selection_presets_fnc_handleUnitVehicleChanged
 *
 * Public: No
 */

params ["_unit", "", "_vehicle"];

[[_unit, _vehicle], group _unit] call FUNC(queueAffectedPresets);
