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

private _fnc_formatDegrees = {
    format ["%1%2", round _this, toString [ASCII_DEGREE]]
};

private _yaw = [getDir _object] call CBA_fnc_simplifyAngle180;
(_object call BIS_fnc_getPitchBank) params ["_pitch", "_roll"];

[LSTRING(RotateObject), [
    ["SLIDER", ELSTRING(common,Pitch), [-180, 180, _pitch, _fnc_formatDegrees], true],
    ["SLIDER", ELSTRING(common,Roll), [-180, 180, _roll, _fnc_formatDegrees], true],
    ["SLIDER", ELSTRING(common,Yaw), [-180, 180, _yaw, _fnc_formatDegrees], true]
], {
    params ["_values", "_object"];
    _values params ["_pitch", "_roll", "_yaw"];

    private _dirAndUp = [[[0, 1, 0], [0, 0, 1]], -_yaw, -_pitch, -_roll] call BIS_fnc_transformVectorDirAndUp;
    [QEGVAR(common,setVectorDirAndUp), [_object, _dirAndUp], _object] call CBA_fnc_targetEvent;
}, {}, _object] call EFUNC(dialog,create);
