/*
 * Author: mharis001
 * Zeus module function to toggle the visibility of an object.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleVisibility
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NothingSelected)] call EFUNC(common,showMessage);
};

[QEGVAR(common,hideObjectGlobal), [_object, !isObjectHidden _object]] call CBA_fnc_serverEvent;
