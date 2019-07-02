/*
 * Author: mharis001
 * Initializes the "Medic" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeMedic
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _ctrlToolbox = _display displayCtrl IDC_MEDIC_TOOLBOX;
_ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlToolbox", "_index"];

    private _display = ctrlParent _ctrlToolbox;
    _display setVariable [QGVAR(medic), _index == 1];
}];

_ctrlToolbox lbSetCurSel parseNumber (_entity getUnitTrait "medic");

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _medic = _display getVariable QGVAR(medic);
    if (isNil "_medic") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    {
        [QEGVAR(common,setUnitTrait), [_x, "medic", _medic], _x] call CBA_fnc_targetEvent;
    } forEach (_entity call FUNC(getAttributeEntities));
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
