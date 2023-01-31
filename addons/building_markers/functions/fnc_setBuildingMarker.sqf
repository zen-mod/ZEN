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

params [["_objects", [], [[], objNull]], ["_setMarker", false, [false]]];

if (_objects isEqualType objNull) then {
    _objects = [_objects];
};

{
    private _object = _x;
    if (!(_object isEqualType objNull) || {isNull _object}) then {continue;};

    private _marker = _object getVariable [QGVAR(buildingMarker), ""];
    private _hasMarker = _marker != "";

    if (_setMarker) then {
        // Update marker
        if (_hasMarker) then {
            _marker setMarkerPosLocal getPos _object;
            _marker setMarkerDir getDir _object;
            continue;
        };

        // Create marker
        _marker = createMarker [format [QGVAR(buildingMarker_%1), _object call bis_fnc_netId], _object];
        _marker setMarkerShapeLocal "RECTANGLE";
        _marker setMarkerSizeLocal (0 boundingBoxReal _object select 1);
        _marker setMarkerDirLocal getDir _object;
        _marker setMarkerColorLocal "ColorGrey";
        _marker setMarkerBrush "SolidFull";

        // Tracking
        _object setVariable [QGVAR(buildingMarker), _marker];
        private _id = _object addEventHandler ["Deleted", {
            params ["_entity"];
            private _marker = _entity getVariable [QGVAR(buildingMarker), ""];
            deleteMarker _marker;
        }];
        _object setVariable [QGVAR(buildingMarkerDeletedEHID), _id];

    } else {
        // _setMarker false
        if !(_hasMarker) then {continue;};

        private _id = _object getVariable [QGVAR(buildingMarkerDeletedEHID), -1];
        if (_id > -1) then {
            _object removeEventHandler ["Deleted", _id];
        };

        _object setVariable [QGVAR(buildingMarker), ""];
        deleteMarker _marker;
    };

} forEach _objects;
