#include "script_component.hpp"
/*
 * Author: mharis001
 * Copies and stores the given vehicle's appearance.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call zen_context_actions_fnc_copyVehicleAppearance
 *
 * Public: No
 */

params ["_vehicle"];

private _customization = _vehicle call BIS_fnc_getVehicleCustomization;
GVAR(appearances) setVariable [typeOf _vehicle, _customization];
