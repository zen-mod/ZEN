#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles changing the area's rotation using the slider or edit box.
 *
 * Arguments:
 * 0: Slider <CONTROL>
 * 1: Edit (not used) <CONTROL>
 * 2: Value <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, CONTROL, 90] call zen_cover_map_fnc_handleRotationChanged
 *
 * Public: No
 */

params ["_ctrlSlider", "", "_angle"];

private _display = ctrlParent _ctrlSlider;
private _ctrlMap = _display displayCtrl IDC_CM_MAP;

// Update the current area's angle if it exists
private _area = _ctrlMap getVariable QGVAR(area);

if (!isNil "_area") then {
    _area set [2, _angle];
};
