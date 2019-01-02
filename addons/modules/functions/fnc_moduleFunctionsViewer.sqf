/*
 * Author: mharis001
 * Zeus module function for opening the functions viewer.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleFunctionsViewer
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];

if (!local _logic) exitWith {};

[] call BIS_fnc_help;

deleteVehicle _logic;
