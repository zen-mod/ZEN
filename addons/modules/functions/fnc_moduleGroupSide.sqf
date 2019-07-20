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
    _dialogValues params ["_side"];

    [group _unit, _side] call EFUNC(common,changeGroupSide);
}, {}, _unit] call EFUNC(dialog,create);
