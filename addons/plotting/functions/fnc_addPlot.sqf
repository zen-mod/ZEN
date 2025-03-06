#include "script_component.hpp"
/*
 * Authors: Timi007
 * Adds a new plot to be drawn.
 *
 * Arguments:
 * 0: Type of plot <STRING>
 * 1: Start position ASL or attached object <ARRAY or OBJECT>
 * 2: End position ASL or attached object <ARRAY or OBJECT>
 *
 * Return Value:
 * Index of new plot <NUMBER>
 *
 * Example:
 * ["RADIUS", player, [100, 100, 10]] call zen_plotting_fnc_addPlot
 *
 * Public: No
 */

params [
    ["_type", "LINE", [""]],
    ["_startPos", [0, 0, 0], [[], objNull], [3]],
    ["_endPos", [0, 0, 0], [[], objNull], [3]]
];

if !(_type in GVAR(plotTypes)) exitWith {-1};

GVAR(plots) pushBack [_type, _startPos, _endPos];
