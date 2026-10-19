#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles a group being created.
 *
 * Arguments:
 * 0: Group <GROUP>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_group] call zen_selection_presets_fnc_handleGroupCreated
 *
 * Public: No
 */

params ["_group"];

private _fnc_handleGroupChange = {
    params ["_group", "_unit"];

    [[_unit, vehicle _unit], _group] call FUNC(queueAffectedPresets);
};

{
    _group addEventHandler [_x, _fnc_handleGroupChange];
} forEach ["UnitJoined", "UnitLeft", "LeaderChanged"];
