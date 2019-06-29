/*
 * Author: Bohemia Interactive, mharis001, Kex
 * Handles placement of a waypoint by Zeus.
 * Edited to allow control over radio messages and fixing waypoint positioning.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Group <OBJECT>
 * 2: Waypoint ID <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [curator, group, waypointID] call BIS_fnc_curatorWaypointPlaced
 *
 * Public: No
 */
#include "script_component.hpp"

params ["", "_group", "_waypointID"];

private _leader = leader _group;
private _waypoint = [_group, _waypointID];
private _waypointType = waypointType _waypoint;

if (GVAR(unitRadioMessages) != 2) then {
    [
        _leader,
        ["CuratorWaypointPlaced", "CuratorWaypointPlacedAttack"] select (_waypointType == "DESTROY")
    ] call BIS_fnc_curatorSayMessage;
};

if (_waypointID == 1) then {
    [_group, 0] setWaypointPosition [getPos _leader, 0];
};

if (_waypointType == "CYCLE") then {
    _waypoint setWaypointPosition [waypointPosition [_group, 0], 0];
};
