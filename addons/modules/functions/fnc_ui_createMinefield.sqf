/*
 * Author: mharis001
 * Initalizes the "Create Minefield" Zeus module display.
 *
 * Arguments:
 * 0: createMinefield controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_createMinefield
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

// Populate list with available mines
private _ctrlType = _display displayCtrl IDC_CREATEMINEFIELD_TYPE;

{
    _x params ["_name", "_class"];
    _ctrlType lbSetData [_ctrlType lbAdd _name, _class];
} forEach (uiNamespace getVariable QGVAR(mineTypes));

_ctrlType lbSetCurSel 0;
lbSort _ctrlType;

// Set default density to medium
private _ctrlDensity = _display displayCtrl IDC_CREATEMINEFIELD_DENSITY;
_ctrlDensity lbSetCurSel 2;

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

    private _ctrlAreaX = _display displayCtrl IDC_CREATEMINEFIELD_AREA_X;
    private _areaWidth = parseNumber ctrlText _ctrlAreaX;

    private _ctrlAreaY = _display displayCtrl IDC_CREATEMINEFIELD_AREA_Y;
    private _areaHeight = parseNumber ctrlText _ctrlAreaY;

    private _ctrlType = _display displayCtrl IDC_CREATEMINEFIELD_TYPE;
    private _mineType = _ctrlType lbData lbCurSel _ctrlType;

    private _ctrlDensity = _display displayCtrl IDC_CREATEMINEFIELD_DENSITY;
    private _mineDensity = lbCurSel _ctrlDensity;

    [_logic modelToWorld [0, 0, 0], _areaWidth, _areaHeight, _mineType, _mineDensity] call FUNC(moduleCreateMinefield);

    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
