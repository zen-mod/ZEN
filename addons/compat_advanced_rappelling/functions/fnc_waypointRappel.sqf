#include "script_component.hpp"
/*
 * Author: Kex
 * Scripted waypoint that makes a group rappel at the waypoint's position.
 * Requires Duda's Advanced Rappelling to be loaded.
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Waypoint Position <ARRAY>
 *
 * Return Value:
 * Waypoint Finished <BOOL>
 *
 * Example:
 * _waypoint setWaypointScript "\x\zen\addons\compat_advanced_rappelling\functions\fnc_waypointRappel.sqf"
 *
 * Public: No
 */

#define RAPPEL_HEIGHT 15

params ["_group", "_waypointPosition"];

private _waypoint = [_group, currentWaypoint _group];
_waypoint setWaypointDescription localize LSTRING(Rappel);

private _vehicle = vehicle leader _group;

// Exit if the helicopter has no passengers that can be deployed by rappelling
if (crew _vehicle findIf {assignedVehicleRole _x select 0 == "cargo"} == -1) exitWith {true};

// Exit if rappelling is not enabled for the helicopter
if !(_vehicle call FUNC(canRappel)) exitWith {true};

// Increase the skill of the pilot for better flying
private _driver = driver _vehicle;
private _skill = skill _driver;
_driver allowFleeing 0;
_driver setSkill 1;

// Set the group's behaviour to careless to prevent it from flying away in combat
private _behaviour = behaviour _vehicle;
_group setBehaviour "CARELESS";

[_vehicle, RAPPEL_HEIGHT, AGLToASL _waypointPosition] call AR_Rappel_All_Cargo;

_driver setSkill _skill;
_group setBehaviour _behaviour;

true
