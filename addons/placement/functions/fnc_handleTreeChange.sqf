#include "script_component.hpp"
/*
 * Author: Brett, mharis001
 * Handles changing the currently active tree.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Mode <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, 0] call zen_placement_fnc_handleTreeChange
 *
 * Public: No
 */

if (!GVAR(enabled)) exitWith {};

params ["_display", "_mode"];

// Setup the preview with if object placement is active
// Otherwise delete the current preview
private _objectType = if (_mode in [0, 4] && {call EFUNC(common,isPlacementActive)}) then {
    private _ctrlTree = call EFUNC(common,getActiveTree);
    private _data = _ctrlTree tvData tvCurSel _ctrlTree;

    if (_mode == 4 && {!isClass (configFile >> "CfgVehicles" >> _data) || {_data isKindOf "Logic"}}) then {
        _data = "";
    };

    _data
} else {
    ""
};

[_objectType] call FUNC(setupPreview);
