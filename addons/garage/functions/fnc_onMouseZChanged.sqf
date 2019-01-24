/*
 * Author: mharis001
 * Handles the MouseZChanged event for the garage display.
 *
 * Arguments:
 * 0: Mouse control (not used) <CONTROL>
 * 1: Scroll amount <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 1] call zen_garage_fnc_onMouseZChanged
 *
 * Public: No
 */
#include "script_component.hpp"

params ["", "_scroll"];

// Calculate max and min camera distance
boundingBoxReal GVAR(center) params ["_vehicleP1", "_vehicleP2"];
private _distanceMax = (_vehicleP1 vectorDistance _vehicleP2) * 1.5;
private _distanceMin = _distanceMax * 0.15;

GVAR(camDistance) = (GVAR(camDistance) - (_scroll / 10)) max _distanceMin min _distanceMax;
