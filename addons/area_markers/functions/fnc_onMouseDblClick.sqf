#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles double clicking a mouse button on an area marker icon.
 *
 * Arguments:
 * 0: Mouse Area <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_area_markers_fnc_onMouseDblClick
 *
 * Public: No
 */

params ["_ctrlMouse", "_button"];

if (_button == 0) then {
    private _marker = ctrlParentControlsGroup _ctrlMouse getVariable [QGVAR(marker), ""];
    [_marker] call FUNC(configure);
};
