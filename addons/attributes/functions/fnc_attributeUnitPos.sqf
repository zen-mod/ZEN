/*
 * Author: mharis001
 * Initializes the "Unit Pos" Zeus attribute.
 *
 * Arguments:
 * 0: Attribute controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_attributeUnitPos
 *
 * Public: No
 */
#include "script_component.hpp"

#define IDCS [IDC_ATTRIBUTEUNITPOS_DOWN, IDC_ATTRIBUTEUNITPOS_CROUCH, IDC_ATTRIBUTEUNITPOS_UP, IDC_ATTRIBUTEUNITPOS_AUTO]
#define STANCES ["DOWN", "MIDDLE", "UP", "AUTO"]

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

if (_entity isEqualType grpNull) then {
    _entity = leader _entity;
};

_control ctrlRemoveAllEventHandlers "SetFocus";

private _fnc_onButtonClick = {
    params ["_activeCtrl"];

    private _display = ctrlParent _activeCtrl;
    private _activeIDC = ctrlIDC _activeCtrl;

    {
        private _ctrl = _display displayCtrl _x;
        private _color = [1, 1, 1, 0.5];
        private _scale = 1;

        if (_activeIDC == _x) then {
            _color set [3, 1];
            _scale = 1.2;
        };

        _ctrl ctrlSetTextColor _color;
        [_ctrl, _scale, 0.1] call BIS_fnc_ctrlSetScale;
    } forEach IDCS;

    private _stance = STANCES select (IDCS find _activeIDC);
    _display setVariable [QGVAR(unitPos), _stance];
};

private _activeIDC = IDCS select (STANCES find toUpper unitPos _entity);

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["ButtonClick", _fnc_onButtonClick];

    if (_activeIDC == _x) then {
        _ctrl ctrlSetTextColor [1, 1, 1, 1];
        [_ctrl, 1.2, 0] call BIS_fnc_ctrlSetScale;
    };
} forEach IDCS;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _stance = _display getVariable QGVAR(unitPos);
    if (isNil "_stance") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    {
        [QEGVAR(common,setUnitPos), [_x, _stance], _x] call CBA_fnc_targetEvent;
    } forEach (_entity call FUNC(getAttributeEntities));
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
