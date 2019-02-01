/*
 * Author: mharis001
 * Initializes the "Earthquake" Zeus module display.
 *
 * Arguments:
 * 0: earthquake controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_earthquake
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_control"];

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
TRACE_1("Logic Object",_logic);

_control ctrlRemoveAllEventHandlers "SetFocus";

private _ctrlRadius = _display displayCtrl IDC_EARTHQUAKE_RADIUS;
[_ctrlRadius, 0, 2000, 100] call FUNC(ui_attributeSlider);

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    deleteVehicle _logic;
};

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    private _ctrlRadius = _display displayCtrl IDC_EARTHQUAKE_RADIUS;
    private _radius = _ctrlRadius getVariable QGVAR(value);

    private _ctrlIntensity = _display displayCtrl IDC_EARTHQUAKE_INTENSITY;
    private _intensity = lbCurSel _ctrlIntensity;

    private _ctrlBuildings = _display displayCtrl IDC_EARTHQUAKE_BUILDINGS;
    private _destroyBuildings = lbCurSel _ctrlBuildings > 0;

    [_logic, _radius, _intensity, _destroyBuildings] call FUNC(moduleEarthquake);
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
