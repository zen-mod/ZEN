#include "script_component.hpp"
/*
 * Author: Kex
 * Handles editing of an object by Zeus.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Edited Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _object] call zen_ai_fnc_handleObjectEdited
 *
 * Public: No
 */

params ["", "_object"];

// Handle rotating garrisoned units
if (_object getVariable [QGVAR(garrisoned), false]) then {
    private _direction = (ASLtoAGL eyePos _object) vectorAdd (vectorDir _object);
    [QEGVAR(common,doWatch), [_object, _direction], _object] call CBA_fnc_targetEvent;
};
