/*
 * Author: mharis001
 * Zeus module function to make a group patrol an area.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_modulePatrolArea
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];

private _unit = effectiveCommander attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

if !(_unit isKindOf "CAManBase") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if !(alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

[LSTRING(ModulePatrolArea), [
    ["SLIDER", [LSTRING(ModulePatrolArea_Radius), LSTRING(ModulePatrolArea_Radius_Tooltip)], [0, 5000, 100, 0]],
    ["TOOLBOX", ["STR_3DEN_Group_Attribute_Behaviour_displayName", LSTRING(ModulePatrolArea_Behaviour_Tooltip)], [0, 1, 4, [
        "STR_3den_attributes_default_unchanged_text",
        LSTRING(ModulePatrolArea_Relaxed),
        LSTRING(ModulePatrolArea_Cautious),
        "STR_combat"
    ]]]
], {
    params ["_dialogValues", "_unit"];
    _dialogValues params ["_radius", "_behaviour"];

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
}, {}, _unit] call EFUNC(dialog,create);
