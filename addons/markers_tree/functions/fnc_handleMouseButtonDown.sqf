#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles pressing a mouse button on the map.
 *
 * Arguments:
 * 0: Map <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_markers_tree_fnc_handleMouseButtonDown
 *
 * Public: No
 */

params ["_ctrlMap", "_button"];

switch (_button) do {
    case 0: {
        _ctrlMap setVariable [QGVAR(holdingLMB), true];
    };
    case 1: {
        private _display = ctrlParent _ctrlMap;
        private _ctrlTreeAreas = _display displayCtrl IDC_MARKERS_TREE_AREAS;

        if (ctrlShown _ctrlTreeAreas) then {
            _ctrlTreeAreas tvSetCurSel [-1];
        };
    };
};
