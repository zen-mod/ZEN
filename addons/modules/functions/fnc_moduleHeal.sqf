/*
 * Author: mharis001
 * Zeus module function to heal a unit.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleHeal
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

if !(_unit isKindOf "CAManBase") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if (!alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

if (isClass (configFile >> "CfgPatches" >> "ace_medical") && {ace_medical_level > 0}) then {
    ["ace_medical_treatmentAdvanced_fullHealLocal", [_unit, _unit], _unit] call CBA_fnc_targetEvent;
} else {
    // BI's scripted revive system
    if ((missionNamespace getVariable ["bis_revive_mode", 0]) != 0) then {
        ["#rev", 1, _unit] call BIS_fnc_reviveOnState;
        _unit setVariable ["#rev", 1, true];
    } else {
        _unit setDamage 0;
    };
};
