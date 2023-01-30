#include "script_component.hpp"
/*
 * Author: Ampersand
 * Toggles a rectangle marker on object bounding box, to make placed building look like terrain building.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * Marker name <STRING>
 *
 * Example:
 * [_object] call zen_area_markers_fnc_toggleBoundingMarker
 *
 * Public: No
 */

params ["_object"];

private _marker = _object getVariable [QGVAR(boundingMarker), ""];

if (_marker isNotEqualTo "") exitWith {
    private _id = _object getVariable [QGVAR(boundingMarkerDeletedEHID), -1];
    if (_id > -1) then {
        _object removeEventHandler ["Deleted", _id];
    };
    _object setVariable [QGVAR(boundingMarker), "", true];
    deleteMarker _marker;
    ""
};

// Marker
_marker = createMarker [format ["%1_%2", QGVAR(BoundingMarker), _object call bis_fnc_netId], _object];
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerSizeLocal ((0 boundingBoxReal _object) select 1);
_marker setMarkerDirLocal getDir _object;
_marker setMarkerColorLocal "ColorGrey";
_marker setMarkerBrush "SolidFull";

// Tracking
_object setVariable [QGVAR(boundingMarker), _marker, true];
private _id = _object addEventHandler ["Deleted", {
	params ["_entity"];
    private _marker = _entity getVariable [QGVAR(boundingMarker), ""];
    deleteMarker _marker;
}];
_object setVariable [QGVAR(boundingMarkerDeletedEHID), _id, true];

_marker
