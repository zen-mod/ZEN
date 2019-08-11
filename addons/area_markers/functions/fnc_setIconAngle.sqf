#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the angle of the given area marker's icon control.
 *
 * Arguments:
 * 0: Marker <STRING>
 * 1: Angle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0", 45] call zen_area_markers_setIconAngle
 *
 * Public: No
 */

params ["_marker", "_angle"];

private _ctrlIcon = GVAR(icons) getVariable _marker;
if (isNil "_ctrlIcon" || {isNull _ctrlIcon}) exitWith {};

_ctrlIcon ctrlSetAngle [_angle, 0.5, 0.5];
