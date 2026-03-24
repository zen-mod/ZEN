#include "script_component.hpp"
/*
 * Author: Ampersand
 * Return the given vehicle's effective gunner (unit seated in a turret with weapons).
 * Priority order is the gunner, commander, other turrets (excluding FFV), and the driver.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Gunner <OBJECT>
 *
 * Example:
 * [_vehicle] call zen_common_fnc_getEffectiveGunner
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]]];

// If a infantry unit is given, return it directly
if (_vehicle isKindOf "CAManBase") exitWith {_vehicle};

// Get units in the vehicle occupying turrets with wepaons
private _units = [gunner _vehicle, commander _vehicle];
_units insert [-1, _vehicle call FUNC(getAllTurrets) apply {_vehicle turretUnit _x}, true];

private _index = _units findIf {
    alive _x && {_vehicle weaponsTurret (_vehicle unitTurret _x) isNotEqualTo []}
};

// Select the first available gunner
// Fall back to effective commander if one in not found and manual fire is enabled
private _gunner = _units param [_index, objNull];

if (isNull _gunner && {isManualFire _vehicle}) then {
    _gunner = effectiveCommander _vehicle;
};

_gunner
