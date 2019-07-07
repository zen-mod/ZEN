#include "script_component.hpp"
/*
 * Author: CreepPork_LV, Kex
 * Zeus module function to remove the virtual arsenal.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleRemoveArsenal
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

if (EGVAR(common,preferredArsenal) == 1 && {isClass (configFile >> "CfgPatches" >> "ace_arsenal")}) then {
    [_object, true] call ace_arsenal_fnc_removeBox;
} else {
    _object call BIS_fnc_removeVirtualWeaponCargo;
    _object call BIS_fnc_removeVirtualMagazineCargo;
    _object call BIS_fnc_removeVirtualItemCargo;
    _object call BIS_fnc_removeVirtualBackpackCargo;
    ["AmmoboxExit", [_object]] call BIS_fnc_arsenal;
};
