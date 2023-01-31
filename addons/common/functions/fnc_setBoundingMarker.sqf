#include "script_component.hpp"
/*
 * Author: Ampersand
 * Addes or removes a rectangle marker on object bounding box, to make placed building look like terrain building. Called by CBA serverEvent.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Set Marker <BOOLEAN>
 *
 * Return Value:
 * Marker name <STRING>
 *
 * Example:
 * [_object, true] call zen_common_fnc_setbuildingMarker
 *
 * Public: No
 */

params ["_object", "_setMarker"];

if !(_object isEqualType objNull) exitWith {""};

private _marker = _object getVariable [QGVAR(buildingMarker), ""];
private _hasMarker = _marker isNotEqualTo "";

if (_setMarker) then {
    if (_hasMarker) exitWith {_marker};
    // Marker
    _marker = createMarker [format ["%1_%2", QGVAR(buildingMarker), _object call bis_fnc_netId], _object];
    _marker setMarkerShapeLocal "RECTANGLE";
    _marker setMarkerSizeLocal ((0 boundingBoxReal _object) select 1);
    _marker setMarkerDirLocal getDir _object;
    _marker setMarkerColorLocal "ColorGrey";
    _marker setMarkerBrush "SolidFull";

    // Tracking
    _object setVariable [QGVAR(buildingMarker), _marker, true];
    private _id = _object addEventHandler ["Deleted", {
    	params ["_entity"];
        private _marker = _entity getVariable [QGVAR(buildingMarker), ""];
        deleteMarker _marker;
    }];
    _object setVariable [QGVAR(buildingMarkerDeletedEHID), _id, true];

    _marker
} else {
    if !(_hasMarker) exitWith {""};

    private _id = _object getVariable [QGVAR(buildingMarkerDeletedEHID), -1];
    if (_id > -1) then {
        _object removeEventHandler ["Deleted", _id];
    };
    _object setVariable [QGVAR(buildingMarker), "", true];
    deleteMarker _marker;

    ""
}
