/*
 * Author: mharis001
 * Initializes the "Patrol Area" Zeus module display.
 *
 * Arguments:
 * 0: patrolArea controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_patrolArea
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

// Validate module target
private _unit = effectiveCommander attachedTo _logic;
TRACE_1("Attached Unit",_unit);

scopeName "Main";
private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call EFUNC(common,showMessage);
    breakOut "Main";
};

switch (false) do {
    case (!isNull _unit): {
        [LSTRING(NothingSelected)] call _fnc_errorAndClose;
    };
    case (_unit isKindOf "CAManBase"): {
        [LSTRING(OnlyInfantry)] call _fnc_errorAndClose;
    };
    case (alive _unit): {
        [LSTRING(OnlyAlive)] call _fnc_errorAndClose;
    };
};

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

    private _unit = effectiveCommander attachedTo _logic;

    private _radius = _display getVariable QGVAR(radius);

    private _ctrlBehaviour = _display displayCtrl IDC_PATROLAREA_BEHAVIOUR;
    private _behaviour = lbCurSel _ctrlBehaviour;

    [_unit, _radius, _behaviour] call FUNC(modulePatrolArea);

    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
