#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles updating a marker.
 *
 * Arguments:
 * 0: Marker <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0"] call zen_area_markers_fnc_onMarkerUpdated
 *
 * Public: No
 */

params ["_marker"];

if (_marker call FUNC(isEditable)) then {
    private _index = GVAR(markers) pushBackUnique _marker;

    // Create icon if the marker was changed into an area marker
    // Otherwise, just update the icon to reflect new marker properties
    if (_index != -1) then {
        _marker call FUNC(createIcon);
    } else {
        _marker call FUNC(updateIcon);
    };
} else {
    GVAR(markers) deleteAt (GVAR(markers) find _marker);
    _marker call FUNC(deleteIcon);
};
