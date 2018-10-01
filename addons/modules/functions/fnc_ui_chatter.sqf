/*
 * Author: mharis001
 * Initializes the "Chatter" Zeus module display.
 *
 * Arguments:
 * 0: chatter controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_chatter
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

if (!isNull _unit) then {
    switch (false) do {
        case (_unit isKindOf "CAManBase"): {
            [LSTRING(OnlyInfantry)] call _fnc_errorAndClose;
        };
        case (alive _unit): {
            [LSTRING(OnlyAlive)] call _fnc_errorAndClose;
        };
        case (!isPlayer _unit): {
            ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call _fnc_errorAndClose;
        };
    };
};

// Handle placing on a unit
private _ctrlLabel = _display displayCtrl IDC_CHATTER_LABEL;

if (isNull _unit) then {
    private _ctrlChannels = _display displayCtrl IDC_CHATTER_CHANNELS;
    _ctrlChannels ctrlEnable false;
    _ctrlChannels ctrlShow false;

    _ctrlLabel ctrlSetText LLSTRING(ModuleChatter_Side);
} else {
    private _ctrlSides = _display displayCtrl IDC_CHATTER_SIDES;
    _ctrlSides ctrlEnable false;
    _ctrlSides ctrlShow false;

    _ctrlLabel ctrlSetText LLSTRING(ModuleChatter_Channel);
};

_display setVariable [QGVAR(useSide), isNull _unit];

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

    private _ctrlMessage = _display displayCtrl IDC_CHATTER_MESSAGE;
    private _message = ctrlText _ctrlMessage;

    // Exit on empty message
    if (_message isEqualTo "") exitWith {};

    private _useSide = _display getVariable QGVAR(useSide);

    private _ctrlSides = _display displayCtrl IDC_CHATTER_SIDES;
    private _side = [_ctrlSides lbValue lbCurSel _ctrlSides] call BIS_fnc_sideType;

    private _ctrlChannels = _display displayCtrl IDC_CHATTER_CHANNELS;
    private _channel = lbCurSel _ctrlChannels;

    [_message, _useSide, _side, _channel, attachedTo _logic] call FUNC(moduleChatter);

    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
