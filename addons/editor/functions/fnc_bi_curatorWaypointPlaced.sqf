#include "script_component.hpp"
/*
 * Author: Bohemia Interactive, mharis001, Kex
 * Handles placement of a waypoint by Zeus.
 * Edited to allow control over radio messages and fixed cycle waypoint position.
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
    [_group, 0] setWaypointPosition [getPosASL _leader, -1];
};

if (_waypointType == "CYCLE") then {
    _waypoint setWaypointPosition [AGLToASL waypointPosition [_group, 0], -1];
};
