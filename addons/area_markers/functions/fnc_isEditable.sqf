#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given marker is an editable area marker.
 *
 * Arguments:
 * 0: Marker <STRING>
 *
 * Return Value:
 * Is Editable <BOOL>
 *
 * Example:
 * ["marker_0"] call zen_area_markers_fnc_isEditable
 *
 * Public: No
 */

params ["_marker"];

markerShape _marker in ["RECTANGLE", "ELLIPSE"]
&& {GVAR(blacklist) findIf {_x in _marker} == -1}
&& {GVAR(editableMarkers) == EDITABLE_MARKERS_ALL || {QUOTE(ADDON) in _marker}}
