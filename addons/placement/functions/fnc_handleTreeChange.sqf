#include "script_component.hpp"
/*
 * Author: Brett, mharis001
 * Handles changing the currently active tree.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Mode <NUMBER>
 * 2: Side <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, 0, 0] call zen_placement_fnc_handleTreeChange
 *
 * Public: No
 */

if (!GVAR(enabled)) exitWith {};

params ["_display", "_mode", "_side"];

// Setup the preview with if object placement is active
// Otherwise delete the current preview
private _objectType = if (_mode == 0 && {call EFUNC(common,isPlacementActive)}) then {
    private _ctrlTree = call EFUNC(common,getActiveTree);
    _ctrlTree tvData tvCurSel _ctrlTree
} else {
    ""
};

[_objectType] call FUNC(setupPreview);
