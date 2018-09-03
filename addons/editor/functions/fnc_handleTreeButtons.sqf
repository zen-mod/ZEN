/*
 * Author: mharis001
 * Handles clicking of tree collapse and expand all buttons.
 *
 * Arguments:
 * 0: Zeus Display <DISPLAY>
 * 1: Expand <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, false] call zen_editor_fnc_handleTreeButtons
 *
 * Public: No
 */
#include "script_component.hpp"

#define UNIT_TREE_IDCS [IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY]
#define GROUP_TREE_IDCS [IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY]

params ["_display", "_expand"];

// determine currently active tree
RscDisplayCurator_sections params ["_mode", "_side"];

// cant collapse marker or recent trees
if (_mode > 2) exitWith {};

private _treeIDC = switch (_mode) do {
    case 0: {
        UNIT_TREE_IDCS select _side;
    };
    case 1: {
        GROUP_TREE_IDCS select _side;
    };
    case 2: {
        IDC_RSCDISPLAYCURATOR_CREATE_MODULES
    };
};

// collapse or expand current tree
private _ctrlTree = _display displayCtrl _treeIDC;

if (_expand) then {
    tvExpandAll _ctrlTree;
} else {
    tvCollapseAll _ctrlTree;
};
