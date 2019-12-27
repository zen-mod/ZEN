#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the currently active Zeus create tree.
 * controlNull when the display is not open.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Active Tree <CONTROL>
 *
 * Example:
 * [] call zen_common_fnc_getActiveTree
 *
 * Public: No
 */

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
if (isNull _display) exitWith {controlNull};

RscDisplayCurator_sections params ["_mode", "_side"];

private _treeIDC = switch (_mode) do {
    case 0: {
        IDCS_UNIT_TREES select _side;
    };
    case 1: {
        IDCS_GROUP_TREES select _side;
    };
    case 2: {
        IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
    };
    case 3: {
        IDC_RSCDISPLAYCURATOR_CREATE_MARKERS;
    };
    case 4: {
        IDC_RSCDISPLAYCURATOR_CREATE_RECENT;
    };
};

_display displayCtrl _treeIDC
