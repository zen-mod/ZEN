/*
 * Author: mharis001
 * Initializes the "Name" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeName
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _ctrlEdit = _display displayCtrl IDC_NAME_EDIT;
_ctrlEdit ctrlSetText name _entity;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

    private _ctrlEdit = _display displayCtrl IDC_NAME_EDIT;
    private _newName = ctrlText _ctrlEdit;
    private _oldName = name _entity;

    // Change names of selected units
    if !(_newName isEqualTo _oldName) then {
        {
            if (alive _x && {_x isKindOf "CAManBase"}) then {
                [QEGVAR(common,setName), [_x, _newName]] call CBA_fnc_globalEvent;
            };
        } forEach (curatorSelected select 0);
    };
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
