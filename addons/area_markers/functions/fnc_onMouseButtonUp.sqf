#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles releasing a mouse button on an area marker icon.
 *
 * Arguments:
 * 0: Mouse Area <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_area_markers_fnc_onMouseButtonUp
 *
 * Public: No
 */

params ["_ctrlMouse", "_button"];

if (_button == 0) then {
    // Update position globally to the current local position once moving is finished
    private _marker = ctrlParentControlsGroup _ctrlMouse getVariable [QGVAR(marker), ""];
    _marker setMarkerPos markerPos _marker;

    _ctrlMouse setVariable [QGVAR(moving), false];
};
