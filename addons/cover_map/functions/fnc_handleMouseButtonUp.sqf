#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles releasing a mouse button on the map.
 *
 * Arguments:
 * 0: Map <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_cover_map_fnc_handleMouseButtonUp
 *
 * Public: No
 */

params ["_ctrlMap", "_button"];

if (_button == 0) then {
    // Reset create and move area tracking variables
    _ctrlMap setVariable [QGVAR(offset), nil];
    _ctrlMap setVariable [QGVAR(corner), nil];

    // Update the area's angle to reflect the current rotation
    // Needed to apply rotation to newly created area
    private _display = ctrlParent _ctrlMap;
    private _ctrlSlider = _display displayCtrl IDC_CM_ROTATION_SLIDER;

    private _area = _ctrlMap getVariable QGVAR(area);
    _area set [2, sliderPosition _ctrlSlider];
};
