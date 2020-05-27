#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the OWNERS content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <ARRAY>
 *   0: Sides <ARRAY>
 *   1: Groups <ARRAY>
 *   2: Players <ARRAY>
 *   3: Tab <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, [[], [], [], 0]] call zen_dialog_fnc_gui_owners
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue", "_settings"];
_settings params ["_hideLabel"];

// Copy value array since it could be a saved value and the common owners control modifies it by reference
private _ctrlOwners = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS;
[_ctrlOwners, +_defaultValue] call EFUNC(common,initOwnersControl);

if (_hideLabel) then {
    private _ctrlLabel = _controlsGroup controlsGroupCtrl IDC_ROW_LABEL;
    _ctrlLabel ctrlShow false;

    _ctrlOwners ctrlSetPositionY 0;
    _ctrlOwners ctrlCommit 0;

    _controlsGroup ctrlSetPositionH POS_H(10);
    _controlsGroup ctrlCommit 0;
};

_controlsGroup setVariable [QFUNC(value), {
    params ["_controlsGroup"];

    private _ctrlOwners = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS;
    _ctrlOwners getVariable QEGVAR(common,value)
}];
