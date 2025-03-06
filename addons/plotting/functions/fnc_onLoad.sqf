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

if (!GVAR(draw3DAdded)) then {
    LOG("Adding Draw3D.");
    addMissionEventHandler ["Draw3D", {call FUNC(onDraw3D)}];
    GVAR(draw3DAdded) = true;
};

if (!GVAR(inputHandlersAdded)) then {
    LOG("Adding input handlers.");
    _display displayAddEventHandler ["MouseButtonDown", {call FUNC(onMouseButtonDown)}];
    _display displayAddEventHandler ["KeyDown", {call FUNC(onKeyDown)}];
    GVAR(inputHandlersAdded) = true;
};

// MapDraw EH needs to be added every time the Zeus display is opened.
LOG("Adding map draw.");
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
_ctrlMap ctrlAddEventHandler ["Draw", {call FUNC(onDraw)}];
_ctrlMap ctrlAddEventHandler ["MouseButtonDown", {call FUNC(onMouseButtonDown)}];
_ctrlMap ctrlAddEventHandler ["KeyDown", {call FUNC(onKeyDown)}];
