/*
 * Author: SilentSpike, Brett
 * Zeus module function to change the side of a group.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleGroupSide
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];

private _unit = effectiveCommander attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

if !(_unit isKindOf "CAManBase") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if !(alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

[LSTRING(ModuleGroupSide), [
    ["SIDES", ELSTRING(common,Side), side group _unit, true]
], {
    params ["_dialogValues", "_unit"];
    _dialogValues params ["_newSide"];

    private _oldGroup = group _unit;

    // Exit if same side selected
    if (side _oldGroup == _newSide) exitWith {};

    private _newGroup = createGroup _newSide;

    // Preserve group id from the previous group if doesn't already exist
    if (allGroups findIf {side _x isEqualTo _newSide && {groupId _oldGroup isEqualTo groupId _newGroup}} == -1) then {
        _newGroup setGroupIdGlobal [groupId _oldGroup];
    };

    // Preserve assigned team for each unit
    {
        private _team = assignedTeam _x;
        [_x] joinSilent _newGroup;
        _x assignTeam _team;
    } forEach units _unit;

    deleteGroup _oldGroup;
}, {}, _unit] call EFUNC(dialog,create);
