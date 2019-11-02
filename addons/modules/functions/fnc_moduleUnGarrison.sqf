#include "script_component.hpp"
/*
 * Author: Alganthe
 * Zeus module function to un-garrison units.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleUnGarrison
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

private _units = units _unit;
[QEGVAR(ai,unGarrison), _units, _units] call CBA_fnc_targetEvent;
