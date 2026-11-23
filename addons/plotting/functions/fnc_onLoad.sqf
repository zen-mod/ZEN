#include "script_component.hpp"
/*
 * Authors: Timi007
 * Function triggered every time the Zeus/Curator display is opened.
 * Adds the draw event handlers to display static and currently active plots in 3D and on the map.
 *
 * Arguments:
 * 0: Zeus Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_display] call zen_plotting_fnc_onLoad
 *
 * Public: No
 */

params ["_display"];
TRACE_1("Zeus display opened",_display);

GVAR(activePlot) = [];

LOG("Adding input handlers.");
_display displayAddEventHandler ["MouseButtonDown", {call FUNC(onMouseButtonDown)}];
_display displayAddEventHandler ["KeyDown", {call FUNC(onKeyDown)}];

[_display] call FUNC(addDrawEventHandlers);
