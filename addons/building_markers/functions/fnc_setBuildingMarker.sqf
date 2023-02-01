#include "script_component.hpp"
/*
 * Author: Ampersand
 * Addes or removes a rectangle marker on object bounding box, to make placed building look like terrain building. Called by CBA serverEvent.
 *
 * Arguments:
 * 0: Object(s) <ARRAY, OBJECT>
 * 1: Set Marker <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[_objects], true] call zen_building_markers_fnc_setBuildingMarker
 *
 * Public: No
 */

params [["_object", [], [[], objNull]], ["_setMarker", false, [false]]];

if (_object isEqualType []) exitWith {
    {
        [_x, _setMarker] call FUNC(setBuildingMarker);
    } forEach _object;
};

if (!(_object isEqualType objNull) || {isNull _object}) exitWith {};

private _marker = _object getVariable [QGVAR(marker), ""];
private _hasMarker = _marker != "";

if (_setMarker) then {
    // Update marker
    if (_hasMarker) then {
        _marker setMarkerPosLocal getPos _object;
        _marker setMarkerDir getDir _object;
        continue;
    };

    // Create marker
    _marker = createMarker [format [QGVAR(buildingMarker_%1), _object call BIS_fnc_netId], _object];
    _marker setMarkerShapeLocal "RECTANGLE";
    _marker setMarkerSizeLocal (0 boundingBoxReal _object select 1);
    _marker setMarkerDirLocal getDir _object;
    _marker setMarkerColorLocal "ColorGrey";
    _marker setMarkerBrush "SolidFull";

    // Tracking
    _object setVariable [QGVAR(marker), _marker, true];
    private _id = _object addEventHandler ["Deleted", {
        params ["_entity"];
        private _marker = _entity getVariable [QGVAR(marker), ""];
        deleteMarker _marker;
    }];
    _object setVariable [QGVAR(buildingMarkerDeletedEHID), _id];

} else {
    if !(_hasMarker) exitWith {};

    private _id = _object getVariable [QGVAR(buildingMarkerDeletedEHID), -1];
    if (_id > -1) then {
        _object removeEventHandler ["Deleted", _id];
    };

    _object setVariable [QGVAR(marker), "", true];
    deleteMarker _marker;
};
