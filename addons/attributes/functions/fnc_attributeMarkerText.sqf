/*
 * Author: mharis001
 * Initializes the "Marker Text" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeMarkerText
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _ctrlEdit = _display displayCtrl IDC_MARKERTEXT_EDIT;
_ctrlEdit ctrlSetText markerText _entity;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

    private _ctrlEdit = _display displayCtrl IDC_MARKERTEXT_EDIT;
    _entity setMarkerText ctrlText _ctrlEdit;
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
