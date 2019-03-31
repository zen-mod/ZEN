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
#include "script_component.hpp"

params ["_building"];

private _doors = [];

{
    if (toLower configName _x find "opendoor" != -1) then {
        private _position = getText (_x >> "position");
        _doors pushBack (_building selectionPosition _position);
    };
} forEach configProperties [configFile >> "CfgVehicles" >> typeOf _building >> "UserActions", "isClass _x"];

_doors
