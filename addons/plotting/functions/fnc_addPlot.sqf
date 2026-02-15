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
 * ID of new plot or -1 on error <NUMBER>
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

if (!(_type in GVAR(plotTypes)) || {_startPos isEqualTo objNull} || {_endPos isEqualTo objNull}) exitWith {-1};

private _id = GVAR(nextID);
GVAR(plots) set [_id, [_type, _startPos, _endPos]];
GVAR(history) pushBack _id;

GVAR(nextID) = GVAR(nextID) + 1;

if (_endPos isEqualType objNull) then {
    _endPos setVariable [QGVAR(attachedPlot), _id];
};

TRACE_4("Plot added",_id,_type,_startPos,_endPos);

_id
