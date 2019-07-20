/*
 * Author: mharis001, 3Mydlo3
 * Heals the given unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call zen_common_fnc_healUnit
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

if (GVAR(aceMedicalLoaded) && {ace_medical_level > 0}) then {
    if (GVAR(aceMedicalTreatmentLoaded)) then {
        ["ace_medical_treatment_fnc_fullHealLocal", [_unit], _unit] call CBA_fnc_targetEvent;
    } else {
        ["ace_medical_treatmentAdvanced_fullHealLocal", [_unit, _unit], _unit] call CBA_fnc_targetEvent;
    };
} else {
    // BI's scripted revive system
    if ((missionNamespace getVariable ["bis_revive_mode", 0]) != 0) then {
        ["#rev", 1, _unit] call BIS_fnc_reviveOnState;
        _unit setVariable ["#rev", 1, true];
    } else {
        _unit setDamage 0;
    };
};
