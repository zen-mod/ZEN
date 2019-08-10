#include "script_component.hpp"
/*
 * Author: mharis001
 * Scripted waypoint that makes a group paradrop at the waypoint's position.
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Waypoint Position <ARRAY>
 *
 * Return Value:
 * Waypoint Finished <BOOL>
 *
 * Example:
 * [group, [0, 0, 0]] call zen_ai_fnc_waypointParadrop
 *
 * Public: No
 */

#define MOVE_DELAY 3

params ["_group", "_waypointPosition"];

private _waypoint = [_group, currentWaypoint _group];
_waypoint setWaypointDescription localize LSTRING(Paradrop);

private _vehicle = vehicle leader _group;

// Exit if the vehicle is not an aircraft
if !(_vehicle isKindOf "Air") exitWith {true};

private _driver = driver _vehicle;
private _skill = skill _driver;

// Increase the skill of the pilot for better flying
_driver setSkill 1;
_driver allowFleeing 0;

private _nextMove = CBA_missionTime;

waitUntil {
    // Periodically issue move commands to 2 km past the waypoint's position
    // Makes the aircraft fly over the waypoint's position and not stop at it
    if (CBA_missionTime >= _nextMove) then {
        private _direction = _vehicle getDir _waypointPosition;
        private _position = _waypointPosition getPos [2000, _direction];
        _vehicle move _position;

        _nextMove = CBA_missionTime + MOVE_DELAY;
    };

    sleep 0.5;

    // Check if the aircraft is close enough to the waypoint to begin paradropping
    // Distance is based on the current speed of aircraft and the number of passengers
    private _passengers = {assignedVehicleRole _x select 0 == "cargo"} count crew _vehicle;
    _vehicle distance2D _waypointPosition < vectorMagnitude velocity _vehicle * 1.5 * _passengers / 2 max 50
};

[_vehicle] call EFUNC(common,ejectPassengers);

_driver setSkill _skill;

true
