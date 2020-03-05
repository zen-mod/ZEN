#include "script_component.hpp"
/*
 * Author: mharis001
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
 * [DISPLAY, 0, 0] call zen_compositions_fnc_handleTreeChange
 *
 * Public: No
 */

params ["_display", "_mode", "_side"];

// Only show compositions panel when the empty compositions tree is shown
private _ctrlPanel = _display displayCtrl IDC_PANEL_GROUP;
_ctrlPanel ctrlShow (_mode == 1 && {_side == 4});

// Remove the helper composition from the recent tree if it is shown
if (_mode == 4) then {
    private _ctrlTree = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_RECENT;

    for "_i" from ((_ctrlTree tvCount []) - 1) to 0 step -1 do {
        if (_ctrlTree tvData [_i] == COMPOSITION_STR) then {
            _ctrlTree tvDelete [_i];
        };
    };
};

// Process any tree additions
[_display] call FUNC(processTreeAdditions);
