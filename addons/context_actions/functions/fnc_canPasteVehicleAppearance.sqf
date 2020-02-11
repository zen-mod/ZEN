#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if a previously copied appearance can be applied to the given vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Can Paste Appearance <BOOL>
 *
 * Example:
 * [_vehicle] call zen_context_actions_fnc_canPasteVehicleAppearance
 *
 * Public: No
 */

params ["_vehicle"];

!isNil {GVAR(appearances) getVariable typeOf _vehicle}
