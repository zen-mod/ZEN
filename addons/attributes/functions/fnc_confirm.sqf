#include "script_component.hpp"
/*
 * Author: mharis001
 * Confirms attribute selections for an entity.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_confirm
 *
 * Public: No
 */

params ["_ctrlButtonOK"];

private _display = ctrlParent _ctrlButtonOK;
private _controls = _display getVariable QGVAR(controls);
private _entity = _display getVariable QGVAR(entity);

{
    _x params ["_controlsGroup", "_condition", "_statement"];

    // Execute control specific confirmation function
    private _fnc_onConfirm = _controlsGroup getVariable [QFUNC(onConfirm), {}];
    _controlsGroup call _fnc_onConfirm;

    // Call the attribute statement if the value was changed and the condition still holds
    private _value = _controlsGroup getVariable QGVAR(value);

    if (!isNil "_value" && {_entity call _condition}) then {
        [_entity, _value] call _statement;
    };
} forEach _controls;
