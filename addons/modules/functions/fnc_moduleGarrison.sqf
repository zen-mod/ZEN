#include "script_component.hpp"
/*
 * Author: Alganthe
 * Zeus module function to garrison units.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleGarrison
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

if (isPlayer _unit) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call EFUNC(common,showMessage);
};

[LSTRING(ModuleGarrison), [
    ["SLIDER:RADIUS", ELSTRING(common,Radius), [5, 5000, 100, 0, _unit]],
    ["TOOLBOX", LSTRING(ModuleGarrison_FillMode), [0, 1, 3, [LSTRING(ModuleGarrison_Even), LSTRING(ModuleGarrison_ByBuilding), LSTRING(ModuleGarrison_Random)]]],
    ["TOOLBOX:YESNO", LSTRING(ModuleGarrison_TopDown), false]
], {
    params ["_dialogValues", "_unit"];
    _dialogValues params ["_radius", "_fillMode", "_topDown"];

    [units _unit, ASLtoAGL getPosASL _unit, _radius, _fillMode, _topDown] call EFUNC(ai,garrison);
}, {}, _unit] call EFUNC(dialog,create);
