#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the door positions of the given building.
 *
 * Arguments:
 * 0: Building <OBJECT>
 *
 * Return Value:
 * Door Positions <ARRAY>
 *
 * Example:
 * [building] call zen_doors_fnc_getDoors
 *
 * Public: No
 */

params ["_building"];

private _doors = [];

{
    if ("opendoor" in toLower configName _x) then {
        private _position = getText (_x >> "position");
        _doors pushBack (_building selectionPosition _position);
    };
} forEach configProperties [configOf _building >> "UserActions", "isClass _x"];

_doors
