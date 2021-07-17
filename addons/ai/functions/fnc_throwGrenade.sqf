#include "script_component.hpp"
/*
 * Author: mharis001
 * Makes the unit throw a grenade at the given position.
 * Must be called where the unit is local.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Grenade Muzzle <STRING>
 * 2: Position ASL <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, "HandGrenadeMuzzle", [0, 0, 0]] call zen_ai_fnc_throwGrenade
 *
 * Public: No
 */

#define AIMING_TIMEOUT 10
#define INITIAL_DELAY 0.5
#define CLEANUP_DELAY 1.5

#define TOLERANCE_TIME 2
#define MIN_TOLERANCE 10
#define MAX_TOLERANCE 45

params ["_unit", "_muzzle", "_position"];

// Create a helper object for the unit to target
private _helper = "Land_HelipadEmpty_F" createVehicleLocal [0, 0, 0];
_helper setPosASL _position;

// Make the unit target the helper object
_unit reveal _helper;
_unit doWatch _helper;
_unit doTarget _helper;

// Disable AI intelligence until unit throws the grenade
// Also interrupts a unit's movement to a waypoint, forcing them to stop
_unit disableAI "FSM";
_unit disableAI "PATH";

// Wait until the unit is aiming at the helper object before throwing the grenade
// Initial delay helps prevent weird issue when the unit is moving to a waypoint and the helper is directly in front of it
[{
    _this set [2, CBA_missionTime];

    [
        {
            params ["_unit", "_helper", "_startTime"];

            if (!alive _unit) exitWith {false};

            // Check that the unit is aiming at the helper, increase tolerance as more time passes
            private _direction = _unit getRelDir _helper;
            private _tolerance = linearConversion [0, TOLERANCE_TIME, CBA_missionTime - _startTime, MIN_TOLERANCE, MAX_TOLERANCE, true];

            _direction <= _tolerance || {_direction >= 360 - _tolerance}
        },
        {
            params ["_unit", "_helper", "", "_muzzle"];

            if (alive _unit) then {
                [_unit, _muzzle] call BIS_fnc_fire;

                // Reset AI intelligence and targeting
                [{
                    params ["_unit"];

                    _unit enableAI "FSM";
                    _unit enableAI "PATH";
                    _unit doWatch objNull;
                }, _unit, CLEANUP_DELAY] call CBA_fnc_waitAndExecute;
            };

            deleteVehicle _helper;
        },
        _this,
        AIMING_TIMEOUT,
        {
            params ["", "_helper"];

            deleteVehicle _helper;
        }
    ] call CBA_fnc_waitUntilAndExecute;
}, [_unit, _helper, 0, _muzzle], INITIAL_DELAY] call CBA_fnc_waitAndExecute;
