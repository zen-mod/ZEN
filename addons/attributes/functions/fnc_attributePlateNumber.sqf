#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Plate Number" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributePlateNumber
 *
 * Public: No
 */

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

if (!isClass (configFile >> "CfgVehicles" >> typeOf _entity >> "PlateInfos")) exitWith {
    private _control = _display displayCtrl IDC_PLATENUMBER;
    _control ctrlEnable false;
    _control ctrlShow false;
};

private _ctrlEdit = _display displayCtrl IDC_PLATENUMBER_EDIT;
_ctrlEdit ctrlSetText getPlateNumber _entity;

private _fnc_limitCharacters = {
    params ["_ctrlEdit"];

    _ctrlEdit ctrlSetText (ctrlText _ctrlEdit select [0, 15]);
};

_ctrlEdit ctrlAddEventHandler ["KeyDown", _fnc_limitCharacters];
_ctrlEdit ctrlAddEventHandler ["KeyUp", _fnc_limitCharacters];

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

    private _ctrlEdit = _display displayCtrl IDC_PLATENUMBER_EDIT;
    private _plateNumber = ctrlText _ctrlEdit;

    if !(_plateNumber isEqualTo getPlateNumber _entity) then {
        [QEGVAR(common,setPlateNumber), [_entity, _plateNumber], _entity] call CBA_fnc_targetEvent;
    };
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
