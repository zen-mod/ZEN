/*
 * Author: mharis001
 * Initializes the "Make Invincible" Zeus module display.
 *
 * Arguments:
 * 0: makeInvincible controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_makeInvincible
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
private _object = attachedTo _logic;
TRACE_1("Attached Unit",_object);

scopeName "Main";
private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call EFUNC(common,showMessage);
    breakOut "Main";
};

if (isNull _object) then {
    [LSTRING(NothingSelected)] call _fnc_errorAndClose;
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

    private _object = attachedTo _logic;

    private _ctrlInvincible = _display displayCtrl IDC_MAKEINVINCIBLE_INVINCIBLE;
    private _invincible = lbCurSel _ctrlInvincible == 0;

    private _ctrlIncludeCrew = _display displayCtrl IDC_MAKEINVINCIBLE_INCLUDECREW;
    private _includeCrew = lbCurSel _ctrlIncludeCrew > 0;

    [QEGVAR(common,allowDamage), [_object, _invincible], _object] call CBA_fnc_targetEvent;

    if (_includeCrew) then {
        {[QEGVAR(common,allowDamage), [_x, _invincible], _x] call CBA_fnc_targetEvent;} forEach crew _object;
    };

    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
