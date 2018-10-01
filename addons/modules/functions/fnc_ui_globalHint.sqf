/*
 * Author: mharis001
 * Initializes the "Global Hint" Zeus module display.
 *
 * Arguments:
 * 0: globalHint controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_globalHint
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

// Add EHs to update preview
private _fnc_updatePreview = {
    params ["_ctrlEdit"];

    private _display = ctrlParent _ctrlEdit;
    private _ctrlPreview = _display displayCtrl IDC_GLOBALHINT_PREVIEW;

    _ctrlPreview ctrlSetStructuredText parseText ctrlText _ctrlEdit;
};

private _ctrlEdit = _display displayCtrl IDC_GLOBALHINT_EDIT;
_ctrlEdit ctrlAddEventHandler ["KeyDown", _fnc_updatePreview];
_ctrlEdit ctrlAddEventHandler ["KeyUp", _fnc_updatePreview];

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

    private _ctrlEdit = _display displayCtrl IDC_GLOBALHINT_EDIT;
    private _message = parseText ctrlText _ctrlEdit;

    [QEGVAR(common,hint), _message] call CBA_fnc_globalEvent;

    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
