/*
 * Author: mharis001
 * Initializes the "Rank" Zeus attribute.
 *
 * Arguments:
 * 0: Attribute controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_ui_attributeRank
 *
 * Public: No
 */
#include "script_component.hpp"

#define IDCS [IDC_ATTRIBUTERANK_PRIVATE, IDC_ATTRIBUTERANK_CORPORAL, IDC_ATTRIBUTERANK_SERGEANT, IDC_ATTRIBUTERANK_LIEUTENANT, IDC_ATTRIBUTERANK_CAPTAIN, IDC_ATTRIBUTERANK_MAJOR, IDC_ATTRIBUTERANK_COLONEL]
#define RANKS ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"]

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

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

    private _rank = RANKS select (IDCS find _activeIDC);
    _display setVariable [QGVAR(rank), _rank];
};

private _activeIDC = IDCS select (RANKS find toUpper rank _entity);

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
    private _rank = _display getVariable QGVAR(rank);
    if (isNil "_rank") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    {
        _x setUnitRank _rank;
    } forEach ([_entity, false] call FUNC(getAttributeEntities));
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
