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
 * Public: None
 */

params ["_helper"];

if (!local _helper) exitWith {};

private _position = getPosATL _helper;
_position set [2, 0]; // does not spawn at height of 0

deleteVehicle _helper;

[QGVAR(spawn), [_position, GVAR(selected)]] call CBA_fnc_serverEvent;
