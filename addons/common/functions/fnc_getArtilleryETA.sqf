#include "script_component.hpp"
/*
 * Author: Kex
 * 
 * Returns ETA to the target in seconds for given artillery unit based on
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
#include "script_component.hpp"

params ["_vehicle", "_targetPosition", "_ammoClass"];

if (_vehicle isKindOf CLASS_VLS_BASE) then {
    private _missileClass = getText (configfile >> "CfgMagazines" >> _ammoClass >> "ammo");
    private _missileMaxSpeed = getNumber (configfile >> "CfgAmmo" >> _missileClass >> "maxSpeed");
    (_targetPosition distance _vehicle) / _missileMaxSpeed
} else {
    _vehicle getArtilleryETA [_targetPosition, _ammoClass]
} // return
