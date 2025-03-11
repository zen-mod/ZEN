#include "script_component.hpp"
/*
 * Authors: Timi007
 * Called from context menu to select the start position of the plot.
 *
 * Arguments:
 * 0: Context menu position ASL <ARRAY>
 * 1: Selected objects <ARRAY>
 * 2: Selected groups <ARRAY>
 * 3: Selected waypoints <ARRAY>
 * 4: Selected markers <ARRAY>
 * 5: Hovered entity <OBJECT>
 * 6: Plot type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[100, 100, 5], [], [], [], [], objNull, "LINE"] call zen_plotting_fnc_selectPosition
 *
 * Public: No
 */

params ["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_type"];

private _posOrObj = switch (true) do {
    case (_hoveredEntity isEqualType objNull && {!isNull _hoveredEntity}): {_hoveredEntity};
    case (count _objects isEqualTo 1): {_objects select 0};
    default {_position};
};

TRACE_1("start pos",_posOrObj);

[_type, _posOrObj] call FUNC(setActivePlot);
