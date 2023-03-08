#include "script_component.hpp"
/*
 * Author: Tuupertunut
 * Returns all turret paths for a vehicle including the driver turret.
 *
 * Arguments:
 * 0: Vehicle <OBJECT|STRING>
 *
 * Return Value:
 * Turret Paths <ARRAY>
 *
 * Example:
 * [vehicle player] call zen_common_fnc_getAllTurrets
 *
 * Public: No
 */

params ["_vehicle"];

private _turrets = if (_vehicle isEqualType objNull) then {
    allTurrets _vehicle
} else {
    [_vehicle] call BIS_fnc_allTurrets
};

// Add the driver turret
_turrets pushBack [-1];

_turrets
