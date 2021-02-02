#include "script_component.hpp"
/*
 * Author: CreepPork
 * Function to parse and add a spectrum device beacon.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Beacon frequency <NUMBER>
 * 2: Maximum distance that the beacon can be picked up <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic, _frequency, _range] call zen_spectrum_fnc_addBeacon
 *
 * Public: No
 */

params ["_logic", "_frequency", "_range"];

if (isNull _logic) exitWith {
    ["Unable to create a new beacon"] call EFUNC(common,showMessage);
}

// Create a new namespace to store our beacons
if (isNull GVAR(spectrumConfig)) then {
    GVAR(spectrumConfig) = [true] call CBA_fnc_createNamespace;
}

// Get the existing beacons in the config
private _beacons = GVAR(spectrumConfig) getVariable [QGVAR(beacons), []];

// Append the new beacon to the beacons
_beacons pushBack [_logic, _frequency, _range];

// Register our changes
GVAR(spectrumConfig) setVariable [QGVAR(beacons), _beacons];
