#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles changing the selection in the engine markers tree.
 *
 * Arguments:
 * 0: Markers Tree <CONTROL>
 * 1: Selected Path <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_markers_tree_fnc_handleEngineSelect
 *
 * Public: No
 */

params ["_ctrlTreeEngine", "_selectedPath"];

if (_selectedPath isEqualTo []) then {
    private _display = ctrlParent _ctrlTreeEngine;
    private _ctrlTreeCustom = _display displayCtrl IDC_MARKERS_TREE;

    if (count tvCurSel _ctrlTreeCustom == 2) then {
        _ctrlTreeCustom tvSetCurSel [-1];
    };
};
