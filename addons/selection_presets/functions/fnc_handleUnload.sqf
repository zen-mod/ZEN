#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles unloading the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_selection_presets_fnc_handleUnload
 *
 * Public: No
 */

params ["_display"];

private _curator = getAssignedCuratorLogic player;
private _presets = [] call FUNC(get);
_curator setVariable [QGVAR(presets), _presets];

// Don't need to delete the preset bar control because closing
// the display destroys its controls
[_display, false] call FUNC(deleteBar);
