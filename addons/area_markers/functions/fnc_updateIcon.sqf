#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates the given area marker's icon control.
 *
 * Arguments:
 * 0: Marker <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0"] call zen_area_markers_fnc_updateIcon
 *
 * Public: No
 */

params ["_marker"];

private _ctrlIcon = GVAR(icons) getOrDefault [_marker, controlNull];
if (isNull _ctrlIcon) exitWith {};

_ctrlIcon ctrlSetAngle [markerDir _marker, 0.5, 0.5];

private _ctrlImage = _ctrlIcon controlsGroupCtrl IDC_ICON_IMAGE;
_ctrlImage ctrlSetTextColor (GVAR(colors) get markerColor _marker);
