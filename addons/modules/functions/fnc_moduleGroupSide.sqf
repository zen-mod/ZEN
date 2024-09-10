#include "script_component.hpp"
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

[LSTRING(GroupSide), [
    [
        "TOOLBOX",
        ELSTRING(common,Target),
        [true, 1, 2, [ELSTRING(common,SelectedUnit), ELSTRING(common,SelectedGroup)]]
    ],
    [
        "SIDES",
        "STR_Eval_TypeSide",
        side group _unit,
        true
    ]
], {
    params ["_values", "_unit"];
    _values params ["_entireGroup", "_side"];

    private _group = group _unit;

    if (_entireGroup || {count units _group == 1}) exitWith {
        [_group, _side] call EFUNC(common,changeGroupSide);
    };

    if (side _group != _side) then {
        [_unit] joinSilent createGroup [_side, true];
    };
}, {}, _unit] call EFUNC(dialog,create);
