#include "script_component.hpp"
/*
 * Author: mharis001
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
 * [DISPLAY, 0] call zen_markers_tree_fnc_handleTreeChange
 *
 * Public: No
 */

params ["_display", "_mode"];

// Show empty side control if not in markers mode
private _ctrlSideEmpty = _display displayCtrl IDC_RSCDISPLAYCURATOR_SIDEEMPTY;
_ctrlSideEmpty ctrlShow (_mode != 3);

// Show marker sub-mode buttons if in markers mode
{
    private _ctrlMode = _display displayCtrl _x;
    _ctrlMode ctrlShow (_mode == 3);
} forEach [IDC_MARKERS_MODE_ICONS, IDC_MARKERS_MODE_AREAS];

// Show the appropriate custom markers tree (icons or areas) when in markers mode, otherwise hide
{
    private _ctrlTree = _display displayCtrl _x;
    _ctrlTree ctrlShow (_mode == 3 && {GVAR(mode) == _forEachIndex});
} forEach [IDC_MARKERS_TREE_ICONS, IDC_MARKERS_TREE_AREAS];
