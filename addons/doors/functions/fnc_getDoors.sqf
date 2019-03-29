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

private _config = configFile >> "CfgVehicles" >> typeOf _building;
private _numberOfDoors = getNumber (_config >> "numberOfDoors");

private _doors = [];

for "_door" from 1 to _numberOfDoors do {
    private _position = getText (_config >> "UserActions" >> format ["OpenDoor_%1", _door] >> "position");
    _doors pushBack (_building selectionPosition _position);
};

_doors
