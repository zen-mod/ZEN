#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles changing the selection in the custom area markers tree.
 *
 * Arguments:
 * 0: Markers Tree <CONTROL>
 * 1: Selected Path <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_markers_tree_fnc_handleAreasSelect
 *
 * Public: No
 */

params ["_ctrlTreeAreas", "_selectedPath"];

// Clear selected entities when starting placement of an area marker
if (_selectedPath isNotEqualTo []) then {
    private _display = ctrlParent _ctrlTreeAreas;
    private _ctrlEntities = _display displayCtrl IDC_RSCDISPLAYCURATOR_ENTITIES;
    _ctrlEntities tvSetCurSel [-1];
};
