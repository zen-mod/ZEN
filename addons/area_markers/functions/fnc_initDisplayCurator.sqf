#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_area_markers_fnc_initDisplayCurator
 *
 * Public: No
 */

params ["_display"];

// Add EH to update area marker icon positions when the map is shown
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
_ctrlMap ctrlAddEventHandler ["Draw", {call FUNC(onDraw)}];

// Add EH to handle deleting area marker by pressing the DELETE key
_display displayAddEventHandler ["KeyDown", {call FUNC(onKeyDown)}];

// Create area marker icons for all area markers
{
    {
        [_x] call FUNC(createIcon);
    } forEach GVAR(markers);
} call CBA_fnc_execNextFrame;
