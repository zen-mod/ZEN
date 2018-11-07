/*
 * Author: mharis001
 * Initializes the "Damage" Zeus attribute.
 *
 * Arguments:
 * 0: Attribute controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_ui_attributeDamage
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

_control ctrlRemoveAllEventHandlers "SetFocus";

private _health = 1 - damage _entity;
private _ctrlSlider = _display displayCtrl IDC_ATTRIBUTEDAMAGE_SLIDER;

private _fnc_onSliderPosChanged = {
    params ["_ctrlSlider", "_value"];

    private _display = ctrlParent _ctrlSlider;
    private _ctrlEdit = _display displayCtrl IDC_ATTRIBUTEDAMAGE_EDIT;
    _ctrlEdit ctrlSetText format ["%1%2", round (_value * 100), "%"];
    _display setVariable [QGVAR(damage), _value];
};

_ctrlSlider sliderSetRange [0, 1];
_ctrlSlider sliderSetPosition _health;

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", _fnc_onSliderPosChanged];

private _ctrlEdit = _display displayCtrl IDC_ATTRIBUTEDAMAGE_EDIT;
_ctrlEdit ctrlSetText format ["%1%2", round (_health * 100), "%"];

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _damage = _display getVariable QGVAR(damage);
    if (isNil "_damage") exitWith {};
    _damage = 1 - _damage;

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    {
        _x setDamage _damage;
        systemChat str _x;
    } forEach (_entity call FUNC(getAttributeEntities));
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
