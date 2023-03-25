#include "script_component.hpp"
/*
 * Author: mharis001
 * Compiles a list of all waypoint types available to Zeus.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_attributes_fnc_compileWaypoints
 *
 * Public: No
 */

private _waypointTypes = configProperties [configFile >> "ZEN_WaypointTypes", "isClass _x"] apply {
    private _condition = compile getText (_x >> "condition");

    if (_condition isEqualTo {}) then {
        _condition = {true};
    };

    [
        getText (_x >> "displayName"),
        getText (_x >> "tooltip"),
        getText (_x >> "type"),
        getText (_x >> "script"),
        _condition,
        getNumber (_x >> "priority")
    ]
};

[_waypointTypes, 5, false] call CBA_fnc_sortNestedArray;

uiNamespace setVariable [QGVAR(waypointTypes), _waypointTypes];
