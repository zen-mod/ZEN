/*
 * Author: mharis001
 * Initializes the "Skill" Zeus attribute.
 *
 * Arguments:
 * 0: Attribute controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_ui_attributeSkill
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

if (_entity isEqualType grpNull) then {
    _entity = leader _entity;
};

_control ctrlRemoveAllEventHandlers "SetFocus";

private _skill = skill _entity;
private _ctrlSlider = _display displayCtrl IDC_ATTRIBUTESKILL_SLIDER;

private _fnc_onSliderPosChanged = {
    params ["_ctrlSlider", "_value"];

    private _display = ctrlParent _ctrlSlider;
    private _ctrlEdit = _display displayCtrl IDC_ATTRIBUTESKILL_EDIT;
    _ctrlEdit ctrlSetText format ["%1%2", round (_value * 100), "%"];
    _display setVariable [QGVAR(skill), _value];
};

_ctrlSlider sliderSetRange [0.2, 1];
_ctrlSlider sliderSetPosition _skill;

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", _fnc_onSliderPosChanged];

private _ctrlEdit = _display displayCtrl IDC_ATTRIBUTESKILL_EDIT;
_ctrlEdit ctrlSetText format ["%1%2", round (_skill * 100), "%"];

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _skill = _display getVariable QGVAR(skill);
    if (isNil "_skill") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    {
        [QEGVAR(common,setSkill), [_x, _skill], _x] call CBA_fnc_targetEvent;
    } forEach (_entity call FUNC(getAttributeEntities));
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
