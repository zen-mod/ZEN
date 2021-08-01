#include "script_component.hpp"
/*
 * Author: Kex
 * Zeus module function to scale an object.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleScaleObject
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

if (isNull attachedTo _object) exitWith {
    [LSTRING(NotAttachedTo)] call EFUNC(common,showMessage);
};

[LSTRING(ScaleObject), [
    ["EDIT", [ELSTRING(common,Scale), LSTRING(ScaleObject_Tooltip)], str (getObjectScale _object)]
], {
    params ["_values", "_object"];
    _values params ["_scale"];

    [QEGVAR(common,setObjectScale), [_object,  parseNumber _scale], _object] call CBA_fnc_targetEvent;
}, {}, _object] call EFUNC(dialog,create);
