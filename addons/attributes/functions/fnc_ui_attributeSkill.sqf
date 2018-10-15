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

_control ctrlRemoveAllEventHandlers "SetFocus";

// Set current skill
if (_entity isEqualType grpNull) then {
    _entity = leader _entity;
};

private _skill = skill _entity;

private _ctrlSlider = _display displayCtrl IDC_ATTRIBUTESKILL_SLIDER;
_ctrlSlider sliderSetRange [0.2, 1];
_ctrlSlider sliderSetSpeed [0.05, 0.1];
_ctrlSlider sliderSetPosition _skill;

private _fnc_updatePos = {
    params ["_ctrlSlider", "_value"];

    private _display = ctrlParent _ctrlSlider;
    private _ctrlEdit = _display displayCtrl IDC_ATTRIBUTESKILL_EDIT;
    _ctrlEdit ctrlSetText format ["%1%2", round (_value * 100), "%"];
};

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", _fnc_updatePos];
[_ctrlSlider, _skill] call _fnc_updatePos;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

    private _ctrlSlider = _display displayCtrl IDC_ATTRIBUTESKILL_SLIDER;
    private _newSkill = sliderPosition _ctrlSlider;

    _entity = if (_entity isEqualType grpNull) then {units _entity} else {[_entity]};
    {_x setSkill _newSkill} forEach _entity;
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
