#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Attach Effect" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_gui_attachEffect
 *
 * Public: No
 */

params ["_display"];

private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

scopeName "Main";
private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call EFUNC(common,showMessage);
    breakOut "Main";
};

private _unit = attachedTo _logic;

if (!isNull _unit) then {
    switch (false) do {
        case (_unit isKindOf "CAManBase"): {
            [LSTRING(OnlyInfantry)] call _fnc_errorAndClose;
        };
        case (alive _unit): {
            [LSTRING(OnlyAlive)] call _fnc_errorAndClose;
        };
    };
};

if (isNull _unit) then {
    (_display displayCtrl IDC_ATTACHEFFECT_TARGET) lbDelete 0;
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

    private _ctrlTarget = _display displayCtrl IDC_ATTACHEFFECT_TARGET;
    private _target = lbCurSel _ctrlTarget;
    if (lbSize _ctrlTarget > 4) then {DEC(_target)};

    private _ctrlEffect = _display displayCtrl IDC_ATTACHEFFECT_EFFECT;
    private _effect = _ctrlEffect lbData lbCurSel _ctrlEffect;

    [_logic, _target, _effect] call FUNC(moduleAttachEffect);
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
