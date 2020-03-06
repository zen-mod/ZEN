#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the given infantry unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call zen_ai_fnc_initMan
 *
 * Public: No
 */

params ["_unit"];

if (!local _unit) exitWith {};

[FUNC(applySkills), _unit] call CBA_fnc_execNextFrame;
