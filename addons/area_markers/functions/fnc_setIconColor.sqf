#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the color of the given area marker's icon control.
 *
 * Arguments:
 * 0: Marker <STRING>
 * 1: Color <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0", "ColorRed"] call zen_area_markers_setIconColor
 *
 * Public: No
 */

params ["_marker", "_color"];

private _ctrlIcon = GVAR(icons) getVariable _marker;
if (isNil "_ctrlIcon" || {isNull _ctrlIcon}) exitWith {};

private _ctrlImage = _ctrlIcon controlsGroupCtrl IDC_ICON_IMAGE;
_ctrlImage ctrlSetTextColor (GVAR(colors) getVariable [_color, [0, 0, 0, 1]]);
