#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles unloading the Zeus Display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_editor_fnc_handleUnload
 *
 * Public: No
 */

params ["_display"];

private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
GVAR(previousMapState) = [ctrlMapScale _ctrlMap, _ctrlMap ctrlMapScreenToWorld [0.5, 0.5]];
