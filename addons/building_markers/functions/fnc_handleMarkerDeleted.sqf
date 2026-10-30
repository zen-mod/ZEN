#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handles a marker being deleted.
 *
 * Arguments:
 * 0: Marker <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0"] call zen_building_markers_fnc_handleMarkerDeleted
 *
 * Public: No
 */

params ["_marker"];

if !(QUOTE(ADDON) in _marker) exitWith {};

private _object = objectFromNetId (_marker splitString "_" select -1);
_object setVariable [QGVAR(marker), nil, true];

// Remove setMarkerDrawPriority JIP event
[_marker] call CBA_fnc_removeGlobalEventJIP;
