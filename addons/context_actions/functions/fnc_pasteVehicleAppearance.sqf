#include "script_component.hpp"
/*
 * Author: mharis001
 * Applies the previously copied appearance to the given vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call zen_context_actions_fnc_pasteVehicleAppearance
 *
 * Public: No
 */

params ["_vehicle"];

private _customization = GVAR(appearances) getVariable typeOf _vehicle;
_customization params ["_textures", "_animations"];

[_vehicle, _textures, _animations, true] call BIS_fnc_initVehicle;
