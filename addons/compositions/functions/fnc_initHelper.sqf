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

private _position = getPos _helper;
deleteVehicle _helper;

[QEGVAR(common,deserializeObjects), [GVAR(selected), _position]] call CBA_fnc_serverEvent;
