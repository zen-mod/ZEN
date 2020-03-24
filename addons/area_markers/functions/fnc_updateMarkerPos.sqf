#include "script_component.hpp"
/*
 * Author: Fusselwurm
 * Set the marker position locally
 *
 * Arguments:
 * 0: Marker <STRING>
 * 1: Marker position
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0", [3265.59,853.12]] call zen_area_markers_fnc_updateMarkerPos
 *
 * Public: No
 */

params ["_marker", "_pos"];

_marker setMarkerPosLocal _pos;
