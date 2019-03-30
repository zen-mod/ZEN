/*
 * Author: mharis001
 * Zeus module function to remote control a unit.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_remote_control_fnc_module
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];

private _unit = effectiveCommander attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorNull"] call EFUNC(common,showMessage);
};

if (isPlayer _unit) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call EFUNC(common,showMessage);
};

if !(alive _unit) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorDestroyed"] call EFUNC(common,showMessage);
};

if !(side group _unit in [west, east, independent, civilian]) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorEmpty"] call EFUNC(common,showMessage);
};

private _owner = _unit getVariable [VAR_OWNER, objNull];

if (!isNull _owner && {_owner in allPlayers} || {isUAVConnected vehicle _unit}) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorControl"] call EFUNC(common,showMessage);
};

[_unit] call FUNC(start);
