#include "script_component.hpp"
/*
 * Author: Kex
 * Returns ETA to the target in seconds for the given artillery unit based on
 * target position and used magazine, -1 if target can't be hit.
 * Also supports VLS.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Target position <ARRAY>
 * 2: Ammo class <STRING>
 *
 * Return Value:
 * ETA in seconds <NUMBER>
 *
 * Example:
 * [artilleryUnit, getPos player, ammoClass] call zen_common_fnc_getArtilleryETA
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]], ["_targetPosition", [0, 0, 0], [[]], 3], ["_ammoClass", "", [""]]];

if (_vehicle call FUNC(isVLS)) then {
    private _missileClass = getText (configfile >> "CfgMagazines" >> _ammoClass >> "ammo");
    private _missileMaxSpeed = getNumber (configfile >> "CfgAmmo" >> _missileClass >> "maxSpeed");
    // The max speed of the missile is approximately 0.94 of the config's maxSpeed
    // The acceleration phase roughly takes 10 s over 900 m
    10 + (((_targetPosition distance _vehicle) - 900) max 0) / (0.94 * _missileMaxSpeed)
} else {
    _vehicle getArtilleryETA [_targetPosition, _ammoClass]
}
