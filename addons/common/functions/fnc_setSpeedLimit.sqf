#include "script_component.hpp"
/*
 * Author: Ampersand
 * Sets the movement speed mode of the given vehicle(s).
 *
 * Arguments:
 * 0: Vehicle <OBJECT|ARRAY>
 * 1: Speed <NUMBER> (default: 0)
 *      Man: Speed modes
 *      Vehicles: km/h
 *
 * 2.12   | forceSpeed              | limitSpeed
 * _speed | neg      zero    pos    | neg        zero    pos     -(_man getSpeed "SLOW")
 * -------|-------------------------|---------------------------------------------------------------------
 * man    | reset    stop    yes    | reset      stop    yes     reverse, doesn't work if combat mode
 * car    | reset    stop    yes    | reset      reset   yes
 * tank   | reset    stop    yes    | reset      reset   yes
 * heli   | no-eff   no-eff  no-eff | reverse    stop    yes
 * plane  | reset    reset   yes    | min        min     yes
 * vtol   | reset    reset   yes    | min        min     yes
 * boat   | reset    stop    yes    | reset      stop    yes
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, 1] call zen_common_fnc_setSpeedLimit
 *
 * Public: No
 */

params ["_vehicle", "_speed"];

if (_vehicle isEqualType []) exitWith {
    {
        [_x, _speed] call FUNC(setSpeedLimit);
    } forEach _vehicle;
};

if (!local _vehicle) exitWith {};

if (_vehicle isKindOf "Helicopter") exitWith {
    if (_speed == 0) exitWith {
        _vehicle limitSpeed (getNumber (configOf _vehicle >> "maxSpeed")); // Reset
    };
    _vehicle limitSpeed _speed; // Allow reverse
};

// Planes, LandVehicle, Ship
if (_speed == 0) then {
    _speed = -1; // Reset
};

_vehicle forceSpeed (_speed / 3.6);
