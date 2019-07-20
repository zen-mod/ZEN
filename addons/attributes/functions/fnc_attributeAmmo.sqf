#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Ammo" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeAmmo
 *
 * Public: No
 */

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _ammo = [_entity] call EFUNC(common,getVehicleAmmo);

// Vehicle has no magazines to set ammo level on
if (_ammo == -1) exitWith {
    private _ctrlAmmo = _display displayCtrl IDC_AMMO;
    _ctrlAmmo ctrlShow false;
};

private _ctrlSlider = _display displayCtrl IDC_AMMO_SLIDER;
_ctrlSlider sliderSetRange [0, 1];
_ctrlSlider sliderSetPosition _ammo;

private _fnc_onSliderPosChanged = {
    params ["_ctrlSlider", "_value"];

    private _display = ctrlParent _ctrlSlider;
    _display setVariable [QGVAR(ammo), _value];

    private _ctrlEdit = _display displayCtrl IDC_AMMO_EDIT;
    _ctrlEdit ctrlSetText FORMAT_PERCENT(_value);
};

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", _fnc_onSliderPosChanged];

private _ctrlEdit = _display displayCtrl IDC_AMMO_EDIT;
_ctrlEdit ctrlSetText FORMAT_PERCENT(_ammo);

private _fnc_onKeyUp = {
    params ["_ctrlEdit"];

    private _display = ctrlParent _ctrlEdit;
    private _value = parseNumber ctrlText _ctrlEdit / 100;

    private _ctrlSlider = _display displayCtrl IDC_AMMO_SLIDER;
    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    _display setVariable [QGVAR(ammo), _value];
};

private _fnc_onKillFocus = {
    params ["_ctrlEdit"];

    private _display = ctrlParent _ctrlEdit;
    private _ctrlSlider = _display displayCtrl IDC_AMMO_SLIDER;

    private _value = sliderPosition _ctrlSlider;
    _ctrlEdit ctrlSetText FORMAT_PERCENT(_value);
};

_ctrlEdit ctrlAddEventHandler ["KeyUp", _fnc_onKeyUp];
_ctrlEdit ctrlAddEventHandler ["KillFocus", _fnc_onKillFocus];

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _ammo = _display getVariable QGVAR(ammo);
    if (isNil "_ammo") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    {
        [_x, _ammo] call EFUNC(common,setVehicleAmmo);
    } forEach (_entity call FUNC(getAttributeEntities));
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
