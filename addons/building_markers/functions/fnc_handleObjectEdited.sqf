#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handles editing of an object by Zeus.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Edited Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _object] call zen_building_markers_fnc_handleObjectEdited
 *
 * Public: No
 */

params ["", "_object"];

// Update building marker
private _marker = _object getVariable [QGVAR(marker), ""];
if (_marker != "") then {
    [QGVAR(setBuildingMarker), [_object, true]] call CBA_fnc_serverEvent;
};
