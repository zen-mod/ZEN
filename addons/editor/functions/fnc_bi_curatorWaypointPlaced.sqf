#include "script_component.hpp"
/*
 * Author: Bohemia Interactive, mharis001, Kex
 * Handles placement of a waypoint by Zeus.
 * Edited to allow control over radio messages
 * and fix cycle waypoint positioning.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Group <GROUP>
 * 2: Waypoint ID <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _group, _waypointID] call BIS_fnc_curatorWaypointPlaced
 *
 * Public: No
 */

params ["", "_group", "_waypointID"];

private _leader = leader _group;
private _waypoint = [_group, _waypointID];
private _waypointType = waypointType _waypoint;

if (_waypointID == 1) then {
    [_group, 0] setWaypointPosition [getPosASL _leader, -1];
};

if (_waypointType == "CYCLE") then {
    _waypoint setWaypointPosition [AGLToASL waypointPosition [_group, 0], -1];
};

if (GVAR(unitRadioMessages) != 2) then {
    [
        _leader,
        ["CuratorWaypointPlaced", "CuratorWaypointPlacedAttack"] select (_waypointType == "DESTROY")
    ] call BIS_fnc_curatorSayMessage;
};
