#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles changing the mode of the create trees.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Mode <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, 0] call zen_markers_tree_fnc_handleModeChange
 *
 * Public: No
 */

params ["_display", "_mode"];

// Show the custom markers tree when the markers mode is selected, otherwise hide
private _ctrlTree = _display displayCtrl IDC_MARKERS_TREE;
_ctrlTree ctrlShow (_mode == 3);
