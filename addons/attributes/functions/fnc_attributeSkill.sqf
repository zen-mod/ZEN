#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Skill" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeSkill
 *
 * Public: No
 */

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

if (_entity isEqualType grpNull) then {
    _entity = leader _entity;
};

private _skill = skill _entity;

private _ctrlSlider = _display displayCtrl IDC_SKILL_SLIDER;
_ctrlSlider sliderSetRange [0.2, 1];
_ctrlSlider sliderSetPosition _skill;

private _fnc_onSliderPosChanged = {
    params ["_ctrlSlider", "_value"];

    private _display = ctrlParent _ctrlSlider;
    _display setVariable [QGVAR(skill), _value];

    private _ctrlEdit = _display displayCtrl IDC_SKILL_EDIT;
    _ctrlEdit ctrlSetText FORMAT_PERCENT(_value);
};

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", _fnc_onSliderPosChanged];

private _ctrlEdit = _display displayCtrl IDC_SKILL_EDIT;
_ctrlEdit ctrlSetText FORMAT_PERCENT(_skill);

private _fnc_onKeyUp = {
    params ["_ctrlEdit"];

    private _display = ctrlParent _ctrlEdit;
    private _value = parseNumber ctrlText _ctrlEdit / 100;

    private _ctrlSlider = _display displayCtrl IDC_SKILL_SLIDER;
    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    _display setVariable [QGVAR(skill), _value];
};

private _fnc_onKillFocus = {
    params ["_ctrlEdit"];

    private _display = ctrlParent _ctrlEdit;
    private _ctrlSlider = _display displayCtrl IDC_SKILL_SLIDER;

    private _value = sliderPosition _ctrlSlider;
    _ctrlEdit ctrlSetText FORMAT_PERCENT(_value);
};

_ctrlEdit ctrlAddEventHandler ["KeyUp", _fnc_onKeyUp];
_ctrlEdit ctrlAddEventHandler ["KillFocus", _fnc_onKillFocus];

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
