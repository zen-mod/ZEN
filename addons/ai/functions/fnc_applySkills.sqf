#include "script_component.hpp"
/*
 * Author: mharis001
 * Applies the global AI skill values to the given unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call zen_ai_fnc_applySkills
 *
 * Public: No
 */

params ["_unit"];

GVAR(skills) params [
    "_enabled",
    "_general",
    "_accuracy",
    "_aimingSpeed",
    "_aimingShake",
    "_commanding",
    "_courage",
    "_spotDistance",
    "_spotTime",
    "_reloadSpeed",
    "_cover",
    "_combat",
    "_suppression"
];

if (_enabled) then {
    _unit setSkill ["general",        _general];
    _unit setSkill ["aimingAccuracy", _accuracy];
    _unit setSkill ["aimingSpeed",    _aimingSpeed];
    _unit setSkill ["aimingShake",    _aimingShake];
    _unit setSkill ["commanding",     _commanding];
    _unit setSkill ["courage",        _courage];
    _unit setSkill ["spotDistance",   _spotDistance];
    _unit setSkill ["spotTime",       _spotTime];
    _unit setSkill ["reloadSpeed",    _reloadSpeed];

    if (_cover) then {
        _unit enableAI "COVER";
    } else {
        _unit disableAI "COVER";
    };

    if (_combat) then {
        _unit enableAI "AUTOCOMBAT";
    } else {
        _unit disableAI "AUTOCOMBAT";
    };

    if (_suppression) then {
        _unit enableAI "SUPPRESSION";
    } else {
        _unit disableAI "SUPPRESSION";
    };
};
