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

uiNamespace setVariable [QGVAR(waypointTypes), configProperties [configFile >> "ZEN_WaypointTypes", "isClass _x"] apply {
    [getText (_x >> "displayName"), getText (_x >> "type"), getText (_x >> "script")]
}];
