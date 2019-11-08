#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to toggle the state of street lamps.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleToggleLamps
 *
 * Public: No
 */

params ["_logic"];

private _position = ASLtoAGL getPosASL _logic;
deleteVehicle _logic;

[LSTRING(ToggleLamps), [
    [
        "EDIT",
        ELSTRING(common,Radius_Units),
        "100"
    ],
    [
        "TOOLBOX",
        "STR_A3_RscAttributeTargetState_Title",
        [true, 1, 2, [ELSTRING(common,Off), ELSTRING(common,On)]]
    ]
], {
    params ["_values", "_position"];
    _values params ["_radius", "_state"];

    {
        // Prevent unnecessary events for objects with no lights
        if !(_x call EFUNC(common,getLightingSelections) isEqualTo []) then {
            [QEGVAR(common,setLampState), [_x, _state], _x call BIS_fnc_netId] call CBA_fnc_globalEventJIP;
        };
    } forEach nearestObjects [_position, ["Building"], parseNumber _radius, true];
}, {}, _position] call EFUNC(dialog,create);
