#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles changing the global AI skill values.
 *
 * Arguments:
 * 0: Variable Name (not used) <STRING>
 * 1: Skill Values <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_variable, _values] call zen_ai_fnc_handleSkillsChange
 *
 * Public: No
 */

params ["", "_skills"];
_skills params ["_enabled"];

// Update skills for all local units if enabled
if (_enabled) then {
    {
        if (local _x) then {
            [_x] call FUNC(applySkills);
        };
    } forEach allUnits;
};
