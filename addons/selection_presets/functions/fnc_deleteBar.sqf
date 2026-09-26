#include "script_component.hpp"
/*
 * Author: mharis001
 * Deletes the selection presets bar.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Delete Control <BOOL> (default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_selection_presets_fnc_deleteBar
 *
 * Public: No
 */

params ["_display", ["_deleteControl", true]];

if (_deleteControl) then {
    ctrlDelete (_display displayCtrl IDC_PRESETS);
};

private _eventHandlers = _display getVariable [QGVAR(eventHandlers), createHashMap];

{
    removeMissionEventHandler [_x, _y];
} forEach _eventHandlers;

_display setVariable [QGVAR(eventHandlers), nil];
