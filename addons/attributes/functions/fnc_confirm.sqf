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
private _entity   = _display getVariable QGVAR(entity);

{
    _x params ["_ctrlAttribute", "_condition", "_statement"];

    // Execute control specific confirmation function if defined
    private _fnc_confirmed = _ctrlAttribute getVariable QFUNC(confirmed);

    if (!isNil "_fnc_confirmed") then {
        _ctrlAttribute call _fnc_confirmed;
    };

    // Call the attribute statement if the value was changed and the condition still holds
    private _value = _ctrlAttribute getVariable QGVAR(value);

    if (!isNil "_value" && {_entity call _condition}) then {
        [_entity, _value] call _statement;
    };
} forEach _controls;
