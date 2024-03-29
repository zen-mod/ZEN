#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles placement of a custom module by calling its associated function.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_custom_modules_fnc_init
 *
 * Public: No
 */

params ["_logic"];

private _index = getNumber (configOf _logic >> QGVAR(id)) - 1;
private _function = GVAR(list) param [_index, []] param [3, {}];

private _position = getPosASL _logic;
deleteVehicle _logic;

// Not using curatorCanAttach because that alters the height of the module
curatorMouseOver params ["_type", "_entity"];
private _attached = if (_type == "OBJECT") then {_entity} else {objNull};

[_position, _attached] call _function;
