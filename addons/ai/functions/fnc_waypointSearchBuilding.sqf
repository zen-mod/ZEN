#include "script_component.hpp"
/*
 * Author: mharis001
 * Scripted waypoint that makes a group search the nearest building.
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Waypoint Position <ARRAY>
 *
 * Return Value:
 * Waypoint Finished <BOOL>
 *
 * Example:
 * _waypoint setWaypointScript "\x\zen\addons\ai\functions\fnc_waypointSearchBuilding.sqf"
 *
 * Public: No
 */

params ["_group", "_waypointPosition"];

private _waypoint = [_group, currentWaypoint _group];
_waypoint setWaypointDescription localize LSTRING(SearchBuilding);

private _building = nearestObject [_waypointPosition, "Building"];

if (!isNull _building) then {
    [_group, _building] call FUNC(searchBuilding);
};

true
