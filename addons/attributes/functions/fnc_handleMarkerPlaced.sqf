#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles placement of a marker by Zeus.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Placed Marker <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic, _marker] call zen_attributes_fnc_handleMarkerPlaced
 *
 * Public: No
 */

params ["", "_marker"];

// Apply the last selected color for this marker type
private _color = GVAR(markerColors) getVariable markerType _marker;

if (!isNil "_color") then {
    _marker setMarkerColor _color;
};
