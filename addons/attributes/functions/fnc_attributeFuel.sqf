/*
 * Author: mharis001
 * Initializes the "Fuel" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeFuel
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _fuel = fuel _entity;

private _ctrlSlider = _display displayCtrl IDC_FUEL_SLIDER;
_ctrlSlider sliderSetRange [0, 1];
_ctrlSlider sliderSetPosition _fuel;

private _fnc_onSliderPosChanged = {
    params ["_ctrlSlider", "_value"];

    private _display = ctrlParent _ctrlSlider;
    _display setVariable [QGVAR(fuel), _value];

    private _ctrlEdit = _display displayCtrl IDC_FUEL_EDIT;
    _ctrlEdit ctrlSetText FORMAT_PERCENT(_value);
};

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", _fnc_onSliderPosChanged];

private _ctrlEdit = _display displayCtrl IDC_FUEL_EDIT;
_ctrlEdit ctrlSetText FORMAT_PERCENT(_fuel);

private _fnc_onKeyUp = {
    params ["_ctrlEdit"];

    private _display = ctrlParent _ctrlEdit;
    private _value = parseNumber ctrlText _ctrlEdit / 100;

    private _ctrlSlider = _display displayCtrl IDC_FUEL_SLIDER;
    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    _display setVariable [QGVAR(fuel), _value];
};

private _fnc_onKillFocus = {
    params ["_ctrlEdit"];

    private _display = ctrlParent _ctrlEdit;
    private _ctrlSlider = _display displayCtrl IDC_FUEL_SLIDER;

    private _value = sliderPosition _ctrlSlider;
    _ctrlEdit ctrlSetText FORMAT_PERCENT(_value);
};

_ctrlEdit ctrlAddEventHandler ["KeyUp", _fnc_onKeyUp];
_ctrlEdit ctrlAddEventHandler ["KillFocus", _fnc_onKillFocus];

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _fuel = _display getVariable QGVAR(fuel);
    if (isNil "_fuel") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    {
        [QEGVAR(common,setFuel), [_x, _fuel], _x] call CBA_fnc_targetEvent;
    } forEach (_entity call FUNC(getAttributeEntities));
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
