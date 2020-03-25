#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to bind a variable to an object.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleBindVariable
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

[LSTRING(BindVariable), [
    ["EDIT", LSTRING(VariableName), ""],
    ["TOOLBOX:YESNO", LSTRING(BroadcastVariable), false]
], {
    params ["_values", "_object"];
    _values params ["_variableName", "_isPublic"];

    if (_variableName == "") exitWith {};

    missionNamespace setVariable [_variableName, _object, _isPublic];
}, {}, _object] call EFUNC(dialog,create);
