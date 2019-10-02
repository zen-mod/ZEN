#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates an icon control for the given area marker.
 *
 * Arguments:
 * 0: Marker <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0"] call zen_area_markers_fnc_createIcon
 *
 * Public: No
 */

params ["_marker"];

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
if (isNull _display) exitWith {};

private _ctrlIcon = _display ctrlCreate [QGVAR(icon), IDC_ICON_GROUP];
_ctrlIcon setVariable [QGVAR(marker), _marker];
_ctrlIcon ctrlShow visibleMap;

GVAR(icons) setVariable [_marker, _ctrlIcon];

[_marker, markerDir _marker, markerColor _marker] call FUNC(updateIcon);
