#include "script_component.hpp"
/*
 * Author: mharis001
 * Deletes the icon control of the given area marker.
 *
 * Arguments:
 * 0: Marker <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0"] call zen_area_markers_fnc_deleteIcon
 *
 * Public: No
 */

params ["_marker"];

if (_marker in GVAR(icons)) then {
    ctrlDelete (GVAR(icons) get _marker);
    GVAR(icons) deleteAt _marker;
};
