/*
 * Author: mharis001
 * Initializes the "Group ID" Zeus attribute.
 *
 * Arguments:
 * 0: Attribute controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_ui_attributeGroupID
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

private _ctrlEdit = _display displayCtrl IDC_ATTRIBUTEGROUPID_EDIT;
_ctrlEdit ctrlSetText groupID _entity;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

    private _ctrlEdit = _display displayCtrl IDC_ATTRIBUTEGROUPID_EDIT;
    private _groupID = ctrlText _ctrlEdit;

    if !(_groupID isEqualTo groupID _entity) then {
        _entity setGroupIdGlobal [_groupID];
    };
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
