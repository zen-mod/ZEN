#include "script_component.hpp"
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

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

private _hide = !isObjectHidden _object;

[QEGVAR(common,hideObjectGlobal), [_object, _hide]] call CBA_fnc_serverEvent;

// Prevent AI from shooting an invisible unit
if (_object isKindOf "CAManBase") exitWith {
    [QEGVAR(common,setCaptive), [_object, _hide], _object] call CBA_fnc_targetEvent;
};
