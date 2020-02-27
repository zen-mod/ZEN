#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to toggle the simulation of an object.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleSimulation
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

[QEGVAR(common,enableSimulationGlobal), [_object, !simulationEnabled _object]] call CBA_fnc_serverEvent;
