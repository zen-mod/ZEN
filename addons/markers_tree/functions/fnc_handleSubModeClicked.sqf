#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking a marker sub-mode button.
 *
 * Arguments:
 * 0: Sub-Mode Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_markers_tree_fnc_handleSubModeClicked
 *
 * Public: No
 */

params ["_ctrlMode"];

// Set appropriate sub-mode based on button
GVAR(mode) = [IDC_MARKERS_MODE_ICONS, IDC_MARKERS_MODE_AREAS] find ctrlIDC _ctrlMode;

// Update visuals of sub-mode buttons and show the appropriate markers tree (icons or areas)
private _display = ctrlParent _ctrlMode;

{
    _x params ["_modeIDC", "_treeIDC"];

    private _ctrlMode = _display displayCtrl _modeIDC;
    private _ctrlTree = _display displayCtrl _treeIDC;
    private _selected = GVAR(mode) == _forEachIndex;

    private _scale = [0.8, 1] select _selected;
    private _alpha = [0.7, 1] select _selected;
    _ctrlMode ctrlSetTextColor [1, 1, 1, _alpha];
    [_ctrlMode, _scale, 0.1] call BIS_fnc_ctrlSetScale;

    _ctrlTree ctrlShow _selected;

    // Cancel any active selection (i.e., placement) for the non-selected tree
    if (!_selected) then {
        _ctrlTree tvSetCurSel [-1];
    };
} forEach [
    [IDC_MARKERS_MODE_ICONS, IDC_MARKERS_TREE_ICONS],
    [IDC_MARKERS_MODE_AREAS, IDC_MARKERS_TREE_AREAS]
];
