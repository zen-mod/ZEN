#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles releasing a mouse button on the map.
 *
 * Arguments:
 * 0: Map <CONTROL>
 * 1: Button <NUMBER>
 * 2: X Position <NUMBER>
 * 3: Y Position <NUMBER>
 * 4: Shift State (not used) <BOOL>
 * 5: Ctrl State <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, 0.5, 0.5, false, true] call zen_markers_tree_fnc_handleMouseButtonUp
 *
 * Public: No
 */

params ["_ctrlMap", "_button", "_posX", "_posY", "", "_ctrl"];

if (_button == 0) then {
    private _display = ctrlParent _ctrlMap;
    private _ctrlTreeAreas = _display displayCtrl IDC_MARKERS_TREE_AREAS;

    if (ctrlShown _ctrlTreeAreas) then {
        // Create marker if placement is confirmed (mouse was not moved after pressing LMB)
        if (_ctrlMap getVariable [QGVAR(holdingLMB), false]) then {
            private _shape = _ctrlTreeAreas tvData tvCurSel _ctrlTreeAreas;

            if (_shape != "") then {
                private _position = _ctrlMap ctrlMapScreenToWorld [_posX, _posY];
                [QEGVAR(area_markers,createMarker), [_position, _shape]] call CBA_fnc_serverEvent;

                // If the control key was not held down, stop placing
                if (!_ctrl) then {
                    _ctrlTreeAreas tvSetCurSel [-1];
                };
            };
        } else {
            // Need frame delay since curatorSelected is not updated until then
            [{
                if (curatorSelected isNotEqualTo [[], [], [], []]) then {
                    _this tvSetCurSel [-1];
                };
            }, _ctrlTreeAreas] call CBA_fnc_execNextFrame;
        };
    };

    _ctrlMap setVariable [QGVAR(holdingLMB), false];
};
