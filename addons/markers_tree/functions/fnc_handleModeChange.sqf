#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the Zeus mode buttons.
 *
 * Arguments:
 * 0: Mode Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_markers_tree_fnc_handleModeChange
 *
 * Public: No
 */

params ["_ctrlMode"];

// Show the custom markers tree when the markers mode is selected, otherwise hide
private _display = ctrlParent _ctrlMode;
private _ctrlTree = _display displayCtrl IDC_MARKERS_TREE;
_ctrlTree ctrlShow (ctrlIDC _ctrlMode == IDC_RSCDISPLAYCURATOR_MODEMARKERS);
