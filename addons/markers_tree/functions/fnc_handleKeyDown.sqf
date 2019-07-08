#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles keyboard input for the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Key Code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, 0] call zen_markers_tree_fnc_keyDown
 *
 * Public: No
 */

// One frame later so RscDisplayCurator_sections is updated
[{
    params ["_display", "_keyCode"];

    // Handle hiding/showing the custom markers tree when the mode is switched using TAB
    if (_keyCode == DIK_TAB) then {
        private _ctrlTree = _display displayCtrl IDC_MARKERS_TREE;
        _ctrlTree ctrlShow (RscDisplayCurator_sections select 0 == 3);
    };
}, _this] call CBA_fnc_execNextFrame;

false
