/*
 * Author: mharis001
 * Zeus module function to equip an object with an ECM.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleEquipWithECM
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

if !(_object isKindOf "Car" || {_object isKindOf "Tank"}) exitWith {
    [LSTRING(OnlyVehicles)] call EFUNC(common,showMessage);
};

private _hasECM = _object getVariable [QGVAR(hasECM), false];

[LSTRING(ModuleEquipWithECM), [
    ["TOOLBOX:YESNO", LSTRING(ModuleEquipWithECM_HasECM), !_hasECM, true]
], {
    params ["_dialogValues", "_object"];
    _dialogValues params ["_hasECM"];

    _object setVariable [QGVAR(hasECM), _hasECM, true];
}, {}, _object] call EFUNC(dialog,create);
