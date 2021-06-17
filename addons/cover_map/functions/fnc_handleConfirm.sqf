#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles pressing the OK button.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_cover_map_fnc_handleConfirm
 *
 * Public: No
 */

params ["_ctrlButtonOK"];

private _display = ctrlParent _ctrlButtonOK;
private _ctrlMap = _display displayCtrl IDC_CM_MAP;
private _area = _ctrlMap getVariable QGVAR(area);

if (isNil "_area") then {
    [QGVAR(remove)] call CBA_fnc_serverEvent;
} else {
    [QGVAR(create), _area] call CBA_fnc_serverEvent;
};
