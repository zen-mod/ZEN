#include "script_component.hpp"
/*
 * Author: mharis001
 * Scripted waypoint that makes a group fastrope at the waypoint's position.
 * Requires ace_fastroping to be loaded.
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Waypoint Position <ARRAY>
 *
 * Return Value:
 * Waypoint Finished <BOOL>
 *
 * Example:
 * _waypoint setWaypointScript "\x\zen\addons\ai\functions\fnc_waypointFastrope.sqf"
 *
 * Public: No
 */

#define MOVE_DELAY 3
#define FASTROPE_HEIGHT 15
#define HEIGHT_DISTANCE 2000
#define MANUAL_DISTANCE 100
#define MANUAL_SPEED 12

params ["_group", "_waypointPosition"];

private _waypoint = [_group, currentWaypoint _group];
_waypoint setWaypointDescription localize LSTRING(Fastrope);

// Exit if ace_fastroping is not loaded
if (!isClass (configFile >> "CfgPatches" >> "ace_fastroping")) exitWith {true};

private _vehicle = vehicle leader _group;

// Exit if the helicopter has no passengers that can be deployed by fastrope
if (crew _vehicle findIf {assignedVehicleRole _x select 0 == "cargo"} == -1) exitWith {true};

private _enabled = getNumber (configOf _vehicle >> "ace_fastroping_enabled");

// Exit if fastroping is not enabled for the helicopter
if (_enabled == 0) exitWith {true};

// Equip the helicopter with FRIES if necessary
if (_enabled == 2 && {isNull (_vehicle getVariable ["ace_fastroping_FRIES", objNull])}) then {
    _vehicle call ace_fastroping_fnc_equipFRIES;
};

// Increase the skill of the pilot for better flying
private _driver = driver _vehicle;
private _skill = skill _driver;

_driver allowFleeing 0;
_driver setSkill 1;

// Set the group's behaviour to careless to prevent it from flying away in combat
private _behaviour = behaviour _vehicle;
_group setBehaviour "CARELESS";

private _nextMove = CBA_missionTime;
private _adjustHeight = true;

waitUntil {
    // Periodically issue move commands the waypoint's position
    if (CBA_missionTime >= _nextMove) then {
        _vehicle doMove _waypointPosition;
        _nextMove = CBA_missionTime + MOVE_DELAY;
    };

    // Set the helicopter to fly at the fastrope height once it is close to the waypoint
    if (_adjustHeight && {_vehicle distance2D _waypointPosition < HEIGHT_DISTANCE}) then {
        _vehicle flyInHeight FASTROPE_HEIGHT;
        _adjustHeight = false;
    };

    sleep 0.5;

    // Check if the helicopter is close enough to the waypoint to manually correct its position
    _vehicle distance2D _waypointPosition < MANUAL_DISTANCE
};

// Manaully position the helicopter to be almost exactly over the waypoint's position
// Without manual handling, the helicopter will not fly directly over the waypoint's position
// Instead, it will stop ~100 m away from it - this looks a bit rough but is the most reliable
// method for getting the helicopter into the correct position
private _startPos = getPosASL _vehicle;
private _endPos   = +_waypointPosition;

// Using the waypointPosition command to get the height of the waypoint
// since the position provided to the waypoint script always has a height of zero
_endPos set [2, FASTROPE_HEIGHT + (waypointPosition _waypoint select 2)];
_endPos = AGLtoASL _endPos;

private _initialVelocity = velocity _vehicle;
private _vectorDir = vectorDir _vehicle;
private _vectorUp = vectorUp _vehicle;

private _startTime = CBA_missionTime;
private _totalTime = (_startPos vectorDistance _endPos) / MANUAL_SPEED;

waitUntil {
    _vehicle setVelocityTransformation [
        _startPos,
        _endPos,
        _initialVelocity,
        [0, 0, 0],
        _vectorDir,
        _vectorDir,
        _vectorUp,
        [0, 0, 1],
        (CBA_missionTime - _startTime) / _totalTime
    ];

    vectorMagnitude velocity _vehicle < 0.5 && {getPos _vehicle select 2 <= FASTROPE_HEIGHT}
};

// Make units fastrope once the helicopter is in position
[_vehicle, false, false] call ace_fastroping_fnc_deployAI;

// Wait for all units to finish fastroping
waitUntil {_vehicle getVariable ["ace_fastroping_deployedRopes", []] isNotEqualTo []};
waitUntil {_vehicle getVariable ["ace_fastroping_deployedRopes", []] isEqualTo []};

// Stow the helicopter's fastrope system
_vehicle call ace_fastroping_fnc_stowFRIES;

_vehicle flyInHeight 100;
_driver setSkill _skill;
_group setBehaviour _behaviour;

true
