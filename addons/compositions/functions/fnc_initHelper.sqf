#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the ZEN composition helper.
 *
 * Arguments:
 * 0: Helper <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_helper] call zen_compositions_fnc_initHelper
 *
 * Public: No
 */

params ["_helper"];

if (!local _helper) exitWith {};

private _position = getPosATL _helper;
_position set [2, 0]; // Does not spawn at height of 0

deleteVehicle _helper;

[QGVAR(spawn), [GVAR(selected), _position]] call CBA_fnc_serverEvent;
