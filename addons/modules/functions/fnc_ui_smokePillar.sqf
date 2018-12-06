/*
 * Author: mharis001
 * Initializes the "Smoke Pillar" Zeus module display.
 *
 * Arguments:
 * 0: smokePillar controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_smokePillar
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
TRACE_1("Logic Object",_logic);

_control ctrlRemoveAllEventHandlers "SetFocus";

// Exit if effect already created
private _particleSources = _logic getVariable QGVAR(particleSources);
if (!isNil "_particleSources") exitWith {
    _display closeDisplay 0;
};

private _ctrlType = _display displayCtrl IDC_SMOKEPILLAR_TYPE;
_ctrlType lbSetCurSel 0;

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    if (_this select 1 == 2) then {
        deleteVehicle _logic;
    };
};

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    private _ctrlType = _display displayCtrl IDC_SMOKEPILLAR_TYPE;
    private _smokeType = lbCurSel _ctrlType;

    [_logic, _smokeType] call FUNC(moduleSmokePillar);
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
