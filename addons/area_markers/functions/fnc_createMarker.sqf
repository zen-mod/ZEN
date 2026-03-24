#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates an area marker.
 * Should only be called on the server for unique marker names.
 *
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Shape <STRING> (default: "RECTANGLE")
 *   - Should be either "ELLIPSE" or "RECTANGLE".
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0], "RECTANGLE"] call zen_area_markers_fnc_createMarker
 *
 * Public: No
 */

params ["_position", ["_shape", "RECTANGLE"]];

private _marker = createMarker [format [QGVAR(%1), GVAR(nextID)], _position];
_marker setMarkerShapeLocal _shape;
_marker setMarkerSize [50, 50];

GVAR(nextID) = GVAR(nextID) + 1;
