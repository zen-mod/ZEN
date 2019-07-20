#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Lock" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeLock
 *
 * Public: No
 */

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _ctrlToolbox = _display displayCtrl IDC_LOCK_TOOLBOX;

if (!alive _entity) exitWith {
    _ctrlToolbox ctrlEnable false;
};

// Changed up order of locked states
_ctrlToolbox lbSetCurSel ([1, 2, 0, 3] select locked _entity);

_ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlToolbox", "_index"];

    private _display = ctrlParent _ctrlToolbox;
    _display setVariable [QGVAR(lock), _ctrlToolbox lbValue _index];
}];

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _lock = _display getVariable QGVAR(lock);
    if (isNil "_lock") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    {
        [QEGVAR(common,lock), [_x, _lock], _x] call CBA_fnc_targetEvent;
    } forEach (_entity call FUNC(getAttributeEntities));
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
