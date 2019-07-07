#include "script_component.hpp"
/*
 * Author: CreepPork_LV, Kex
 * Zeus module function to add the full virtual arsenal.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleAddFullArsenal
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
    [_object, true, true] call ace_arsenal_fnc_initBox;
} else {
    ["AmmoboxInit", [_object, true]] call BIS_fnc_arsenal;
};
