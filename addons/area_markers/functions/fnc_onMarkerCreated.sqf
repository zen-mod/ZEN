#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles creating a marker.
 *
 * Arguments:
 * 0: Marker <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0"] call zen_area_markers_fnc_onMarkerCreated
 *
 * Public: No
 */

params ["_marker"];

if (_marker call FUNC(isEditable)) then {
    GVAR(markers) pushBack _marker;
    _marker call FUNC(createIcon);
};
