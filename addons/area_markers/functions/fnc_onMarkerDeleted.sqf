#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles deleting a marker.
 *
 * Arguments:
 * 0: Marker <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0"] call zen_area_markers_fnc_onMarkerDeleted
 *
 * Public: No
 */

params ["_marker"];

GVAR(markers) deleteAt (GVAR(markers) find _marker);
_marker call FUNC(deleteIcon);
