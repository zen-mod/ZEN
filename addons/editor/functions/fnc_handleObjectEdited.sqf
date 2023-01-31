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
 * [_curator, _object] call zen_editor_fnc_handleObjectEdited
 *
 * Public: No
 */

params ["", "_object"];

// Update building marker
if (_object isKindOf "Building") then {
    private _marker = _object getVariable [QEGVAR(common,buildingMarker), ""];
    if (_marker isNotEqualTo "") then {
        [QEGVAR(common,setbuildingMarker), [_object, true]] call CBA_fnc_serverEvent;
    };
};
