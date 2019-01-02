/*
 * Author: mharis001
 * Initializes the "Create IED" Zeus module display.
 *
 * Arguments:
 * 0: createIED controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_createIED
 *
 * Public: No
 */
#include "script_component.hpp"

#define IDCS [IDC_OPFOR, IDC_BLUFOR, IDC_INDEPENDENT, IDC_CIVILIAN]

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
TRACE_1("Logic Object",_logic);

_control ctrlRemoveAllEventHandlers "SetFocus";

// Validate module target
private _object = attachedTo _logic;

scopeName "Main";
private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call EFUNC(common,showMessage);
    breakOut "Main";
};

switch (true) do {
    case (isNull _object): {
        [LSTRING(NothingSelected)] call _fnc_errorAndClose;
    };
    case (!alive _object): {
        [LSTRING(OnlyAlive)] call _fnc_errorAndClose;
    };
    case (_object isKindOf "CAManBase"): {
        [LSTRING(OnlyNonInfantry)] call _fnc_errorAndClose;
    };
    case (_object getVariable [QGVAR(isIED), false]): {
        [LSTRING(AlreadyAnIED)] call _fnc_errorAndClose;
    };
};

private _fnc_onSideClick = {
    params ["_activeCtrl"];

    private _display = ctrlParent _activeCtrl;
    private _activeIDC = ctrlIDC _activeCtrl;

    {
        private _ctrl = _display displayCtrl _x;
        private _color = _ctrl getVariable QGVAR(color);
        private _scale = 1;

        if (_activeIDC == _x) then {
            _color set [3, 1];
            _scale = 1.2;
        } else {
            _color set [3, 0.5];
        };

        _ctrl ctrlSetTextColor _color;
        [_ctrl, _scale, 0.1] call BIS_fnc_ctrlSetScale;
    } forEach IDCS;

    private _side = [IDCS find _activeIDC] call BIS_fnc_sideType;
    _display setVariable [QGVAR(activationSide), _side];
};

private _activeIDC = IDC_BLUFOR;

{
    private _ctrl = _display displayCtrl _x;
    private _color = [_forEachIndex] call BIS_fnc_sideColor;
    _ctrl setVariable [QGVAR(color), _color];
    _ctrl ctrlSetActiveColor _color;
    _color set [3, 0.5];

    if (_activeIDC == _x) then {
        [_ctrl, 1.2, 0] call BIS_fnc_ctrlSetScale;
        _color set [3, 1];
    };

    _ctrl ctrlSetTextColor _color;
    _ctrl ctrlAddEventHandler ["ButtonClick", _fnc_onSideClick];
} forEach IDCS;

private _fnc_onSliderPosChanged = {
    params ["_ctrlSlider", "_value"];

    private _display = ctrlParent _ctrlSlider;
    private _ctrlEdit = _display displayCtrl IDC_CREATEIED_RADIUS_EDIT;
    _ctrlEdit ctrlSetText str round _value;
};

private _ctrlSlider = _display displayCtrl IDC_CREATEIED_RADIUS_SLIDER;
private _ctrlEdit = _display displayCtrl IDC_CREATEIED_RADIUS_EDIT;

_ctrlSlider sliderSetRange [5, 50];
_ctrlSlider sliderSetSpeed [1, 1];
_ctrlSlider sliderSetPosition 10;
_ctrlEdit ctrlSetText "10";

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", _fnc_onSliderPosChanged];

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
    private _activationSide = _display getVariable [QGVAR(activationSide), west];

    private _ctrlRadiusSlider = _display displayCtrl IDC_CREATEIED_RADIUS_SLIDER;
    private _activationRadius = round sliderPosition _ctrlRadiusSlider;

    private _ctrlExplosionSize = _display displayCtrl IDC_CREATEIED_EXPLOSION;
    private _explosionSize = lbCurSel _ctrlExplosionSize;

    private _ctrlJammable = _display displayCtrl IDC_CREATEIED_JAMMABLE;
    private _isJammable = lbCurSel _ctrlJammable > 0;

    [_object, _activationSide, _activationRadius, _explosionSize, _isJammable] call FUNC(moduleCreateIED);

    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
