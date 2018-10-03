/*
 * Author: mharis001
 * Makes group of unit randomly patrol the area.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Radius <NUMBER>
 * 2: Behaviour (0 - Unchanged, 1 - Relaxed, 2 - Cautious, 3 - Combat) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit, 100, 0] call zen_modules_fnc_modulePatrolArea
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_radius", "_behaviour"];
TRACE_1("Module Patrol Area",_this);

// Modify behaviour based on setting
if (_behaviour > 0) then {
    [QEGVAR(common,setFormation), [_unit, "COLUMN"], _unit] call CBA_fnc_targetEvent;

    private _speedMode = ["LIMITED", "NORMAL"] select (_behaviour > 1);
    [QEGVAR(common,setSpeedMode), [_unit, _speedMode], _unit] call CBA_fnc_targetEvent;

    private _behaviourMode = ["SAFE", "AWARE", "COMBAT"] select (_behaviour - 1);
    [QEGVAR(common,setBehaviour), [_unit, _behaviourMode], _unit] call CBA_fnc_targetEvent;
};

// Create patrol waypoints
[QGVAR(taskPatrol), [_unit, _unit, _radius, 5], _unit] call CBA_fnc_targetEvent;
