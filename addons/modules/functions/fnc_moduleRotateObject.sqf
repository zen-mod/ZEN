#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to rotate an object around the X, Y, and Z axes.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleRotateObject
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

private _yaw = [getDir _object] call CBA_fnc_simplifyAngle180;
(_object call BIS_fnc_getPitchBank) params ["_pitch", "_roll"];

[LSTRING(RotateObject), [
    ["SLIDER", ELSTRING(common,Pitch), [-180, 180, _pitch, EFUNC(common,formatDegrees)], true],
    ["SLIDER", ELSTRING(common,Roll), [-180, 180, _roll, EFUNC(common,formatDegrees)], true],
    ["SLIDER", ELSTRING(common,Yaw), [-180, 180, _yaw, EFUNC(common,formatDegrees)], true]
], {
    params ["_values", "_object"];
    _values params ["_pitch", "_roll", "_yaw"];

    [QGVAR(setRotation), [_object, _pitch, _roll, _yaw], _object] call CBA_fnc_targetEvent;
}, {}, _object] call EFUNC(dialog,create);
