#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates the angle and color of the given area marker's icon control.
 *
 * Arguments:
 * 0: Marker <STRING>
 * 1: Angle <NUMBER>
 * 2: Color <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0", 45, "ColorRed"] call zen_area_markers_fnc_updateIcon
 *
 * Public: No
 */

params ["_marker", "_angle", "_color"];

private _ctrlIcon = GVAR(icons) getVariable _marker;
if (isNil "_ctrlIcon" || {isNull _ctrlIcon}) exitWith {};

_ctrlIcon ctrlSetAngle [_angle, 0.5, 0.5];

private _ctrlImage = _ctrlIcon controlsGroupCtrl IDC_ICON_IMAGE;
_ctrlImage ctrlSetTextColor (GVAR(colors) getVariable [_color, [0, 0, 0, 1]]);
