/*
 * Author: Bohemia Interactive, mharis001
 * Handles placement of a waypoint by Zeus.
 * Edited to allow control over radio messages.
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

if (GVAR(unitRadioMessages) == 2) exitWith {};

params ["", "_group", "_waypointID"];

[
    leader _group,
    ["CuratorWaypointPlaced", "CuratorWaypointPlacedAttack"] select (waypointType [_group, _waypointID] == "DESTROY")
] call BIS_fnc_curatorSayMessage;
