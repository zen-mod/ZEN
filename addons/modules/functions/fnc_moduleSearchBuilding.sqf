#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to make a group search a building.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleSearchBuilding
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

[_unit, {
    params ["_successful", "_unit", "_position"];

    if (!_successful) exitWith {};

    private _building = nearestObject [ASLtoAGL _position, "Building"];

    if (isNull _building) exitWith {
        [LSTRING(NoBuildingFound)] call EFUNC(common,showMessage);
    };

    [group _unit, _building] call EFUNC(ai,searchBuilding);
}, [], ELSTRING(ai,SearchBuilding)] call EFUNC(common,selectPosition);
