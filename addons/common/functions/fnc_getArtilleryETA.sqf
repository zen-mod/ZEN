#include "script_component.hpp"
/*
 * Author: Kex
 * Returns ETA to the target in seconds for the given artillery or VLS unit based on
 * the target position and magazine, -1 is returned if position can't be hit.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Position <ARRAY>
 * 2: Magazine <STRING>
 *
 * Return Value:
 * ETA (in seconds) <NUMBER>
 *
 * Example:
 * [_vehicle, _position, _magazine] call zen_common_fnc_getArtilleryETA
 *
 * Public: No
 */

// The acceleration phase roughly takes 10 s over 900 m
#define ACCELERATION_TIME 10
#define ACCELERATION_DISTANCE 900

// The max speed of the missile is approximately 94% of the config defined max speed
#define SPEED_COEFFICIENT 0.94

params [["_vehicle", objNull, [objNull]], ["_position", [0, 0, 0], [[]], 3], ["_magazine", "", [""]]];

if (_vehicle call FUNC(isVLS)) then {
    private _missileType = getText (configfile >> "CfgMagazines" >> _magazine >> "ammo");
    private _maxSpeed = getNumber (configfile >> "CfgAmmo" >> _missileType >> "maxSpeed");

    ACCELERATION_TIME + (((_vehicle distance _position) - ACCELERATION_DISTANCE) max 0) / (SPEED_COEFFICIENT * _maxSpeed)
} else {
    _vehicle getArtilleryETA [_position, _magazine]
};
