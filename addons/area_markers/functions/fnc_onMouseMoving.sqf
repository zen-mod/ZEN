#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles moving the mouse on an area marker icon.
 *
 * Arguments:
 * 0: Mouse Area <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_area_markers_fnc_onMouseMoving
 *
 * Public: No
 */

params ["_ctrlMouse"];

if (_ctrlMouse getVariable [QGVAR(moving), false]) then {
    private _ctrlMap = ctrlParent _ctrlMouse displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;

    private _marker = ctrlParentControlsGroup _ctrlMouse getVariable [QGVAR(marker), ""];
    _marker setMarkerPosLocal (_ctrlMap ctrlMapScreenToWorld getMousePosition);
};
