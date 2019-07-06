/*
 * Author: mharis001
 * Checks if Zeus display is currently in placement mode.
 * User has an entity to place selected.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * In Placement Mode <BOOL>
 *
 * Example:
 * [] call zen_common_fnc_isPlacementActive
 *
 * Public: No
 */
#include "script_component.hpp"

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
if (isNull _display) exitWith {false};

RscDisplayCurator_sections params ["_mode", "_side"];

// Get the active tree IDC and the path length necessary for placement with that tree type
private _treeArgs = switch (_mode) do {
    case 0: {
        [IDCS_UNIT_TREES select _side, 3];
    };
    case 1: {
        [IDCS_GROUP_TREES select _side, 4];
    };
    case 2: {
        [IDC_RSCDISPLAYCURATOR_CREATE_MODULES, 2];
    };
    case 3: {
        [IDC_RSCDISPLAYCURATOR_CREATE_MARKERS, 1];
    };
    case 4: {
        [IDC_RSCDISPLAYCURATOR_CREATE_RECENT, 1];
    };
};

_treeArgs params ["_treeIDC", "_pathLength"];
count tvCurSel (_display displayCtrl _treeIDC) == _pathLength
