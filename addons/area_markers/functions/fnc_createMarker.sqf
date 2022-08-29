#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates an area marker.
 * Should only be called on the server for unique marker names.
 *
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0]] call zen_area_markers_fnc_createMarker
 *
 * Public: No
 */

params ["_position"];

private _marker = createMarker [format [QGVAR(%1), GVAR(nextID)], _position];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize [50, 50];

GVAR(nextID) = GVAR(nextID) + 1;
