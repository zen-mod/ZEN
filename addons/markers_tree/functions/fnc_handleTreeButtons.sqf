#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the tree collapse and expand all buttons.
 *
 * Arguments:
 * 0: Expand <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [false] call zen_markers_tree_fnc_handleTreeButtons
 *
 * Public: No
 */

params ["_expand"];

// Only handle the custom markers tree, rest are handled by editor component
if (RscDisplayCurator_sections select 0 != 3) exitWith {};

private _ctrlTree = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_MARKERS_TREE;

if (_expand) then {
    tvExpandAll _ctrlTree;
} else {
    _ctrlTree call EFUNC(common,collapseTree);
};
