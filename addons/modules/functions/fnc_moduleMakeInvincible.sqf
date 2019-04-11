/*
 * Author: mharis001
 * Zeus module function to make an object invincible.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleMakeInvincible
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NothingSelected)] call EFUNC(common,showMessage);
};

[LSTRING(ModuleMakeInvincible), [
    ["TOOLBOX:YESNO", LSTRING(ModuleMakeInvincible_Invincible), true],
    ["TOOLBOX:YESNO", LSTRING(ModuleMakeInvincible_IncludeCrew), false]
], {
    params ["_dialogValues", "_object"];
    _dialogValues params ["_invincible", "_includeCrew"];

    private _allowDamage = !_invincible;

    [QEGVAR(common,allowDamage), [_object, _allowDamage], _object] call CBA_fnc_targetEvent;

    if (_includeCrew) then {
        {
            [QEGVAR(common,allowDamage), [_x, _allowDamage], _x] call CBA_fnc_targetEvent
        } forEach crew _object;
    };
}, {}, _object] call EFUNC(dialog,create);
