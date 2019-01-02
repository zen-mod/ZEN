/*
 * Author: mharis001
 * Zeus module function to show an objects config.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleShowInConfig
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];

if (!local _logic) exitWith {};

private _object = attachedTo _logic;
deleteVehicle _logic;

if (!isNull _object) then {
    BIS_fnc_configViewer_path = ["configFile", "CfgVehicles"];
    BIS_fnc_configViewer_selected = typeOf _object;
};

[] call BIS_fnc_configViewer;
