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

private _ctrlIcon = GVAR(icons) getVariable _marker;
if (isNil "_ctrlIcon" || {isNull _ctrlIcon}) exitWith {};

GVAR(icons) setVariable [_marker, nil];

ctrlDelete _ctrlIcon;
