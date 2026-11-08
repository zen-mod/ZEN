#include "script_component.hpp"
/*
 * Author: Ampersand
 * Creates or deletes the given object's building marker.
 *
 * Building markers are grey rectangle area markers for the object's bounding box
 * that mimic those of terrain buildings.
 *
 * When called in create mode for an object that already has a building marker,
 * the object's marker is updated to reflect its current position and direction.
 *
 * The marker is automatically updated if the object is edited by Zeus and
 * deleted when the object is deleted. However, the marker will not update if the
 * object is edited by some other means (e.g., through script).
 *
 * Arguments:
 * 0: Object(s) <OBJECT|ARRAY>
 * 1: Set (create or delete) <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, true] call zen_building_markers_fnc_set
 *
 * Public: No
 */

if (!isServer) exitWith {
    [QGVAR(set), _this] call CBA_fnc_serverEvent;
};

params [["_object", objNull, [objNull, []]], ["_set", true, [true]]];

if (_object isEqualType []) exitWith {
    {
        [_x, _set] call FUNC(set);
    } forEach _object;
};

if (isNull _object) exitWith {};

private _marker = _object getVariable [QGVAR(marker), ""];

if (_set) then {
    // Only update marker if it already exists
    if (_marker != "") exitWith {
        _marker setMarkerPosLocal getPos _object;
        _marker setMarkerDir getDir _object;
    };

    // Create marker for the given object
    0 boundingBoxReal _object params ["_p0", "_p1"];
    private _size = _p1 vectorDiff _p0 vectorMultiply 0.5 select [0, 2];

    _marker = createMarker [format [QGVAR(%1), netId _object], _object];
    _marker setMarkerShapeLocal "RECTANGLE";
    _marker setMarkerColorLocal "ColorGrey";
    _marker setMarkerBrushLocal "SolidFull";
    _marker setMarkerSizeLocal _size;
    _marker setMarkerDir getDir _object;
    _object setVariable [QGVAR(marker), _marker, true];

    [QEGVAR(common,setMarkerDrawPriority), [_marker, -999], _marker] call CBA_fnc_globalEventJIP;
} else {
    if (_marker == "") exitWith {};

    deleteMarker _marker;
};
