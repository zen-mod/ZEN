#include "script_component.hpp"
/*
 * Author: Timi007
 * Adds the draw event handlers to display static and currently active plots in 3D and on the map.
 * Does nothing for event handlers that are already added.
 *
 * Arguments:
 * 0: Zeus Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_display] call zen_plotting_fnc_addDrawEventHandlers
 *
 * Public: No
 */

params ["_display"];

if (!GVAR(enabled) || {isNull _display}) exitWith {};

if (!GVAR(draw3DAdded)) then {
    LOG("Adding Draw3D.");
    addMissionEventHandler ["Draw3D", {call FUNC(onDraw3D)}];
    GVAR(draw3DAdded) = true;
};

// MapDraw EH needs to be added every time the Zeus display is opened.
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
if (isNil {_ctrlMap getVariable QGVAR(drawEH)}) then {
    LOG("Adding map draw.");
    _ctrlMap setVariable [QGVAR(drawEH), _ctrlMap ctrlAddEventHandler ["Draw", {call FUNC(onDraw)}]];
};
