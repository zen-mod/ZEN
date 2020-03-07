#include "script_component.hpp"
/*
 * Author: SilentSpike, Brett
 * Changes the given group's side to the specified side.
 * Preserves team assignments and group ID (when possible).
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Side <SIDE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_group, west] call zen_common_fnc_changeGroupSide
 *
 * Public: No
 */

params ["_group", "_side"];

// Exit if group is already a part of given side
if (side _group == _side) exitWith {};

private _newGroup = createGroup [_side, true];
private _groupId = groupId _group;

// Preserve group id from the previous group if doesn't already exist
if (allGroups findIf {side _x isEqualTo _side && {groupId _x isEqualTo _groupId}} == -1) then {
    _newGroup setGroupIdGlobal [_groupId];
};

// Preserve assigned team for each unit
{
    private _team = assignedTeam _x;
    [_x] joinSilent _newGroup;
    _x assignTeam _team;
} forEach units _group;

deleteGroup _group;
