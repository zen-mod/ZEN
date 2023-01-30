#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create an area marker.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_area_markers_fnc_module
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (!isNull _object && {_object isKindOf "Building"}) exitWith {
    [_object] call FUNC(toggleBoundingMarker);
};

if (!visibleMap) exitWith {
    [LSTRING(PlaceOnMap)] call EFUNC(common,showMessage);
};

private _ctrlMap = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
private _position = _ctrlMap ctrlMapScreenToWorld getMousePosition;

[QGVAR(create), [_position]] call CBA_fnc_serverEvent;
