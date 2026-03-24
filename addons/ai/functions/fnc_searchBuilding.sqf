#include "script_component.hpp"
/*
 * Author: mharis001
 * Makes the given group search the specified building.
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Building <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_group, _building] call zen_ai_fnc_searchBuilding
 *
 * Public: No
 */

params ["_group", "_building"];

// Get all building positions, sort them bottom up so each floor is searched in order
private _positions = [_building] call CBA_fnc_buildingPositions;
[_positions, 2, true] call CBA_fnc_sortNestedArray;

// Exit if the building has no positions to search
if (_positions isEqualTo []) exitWith {};

// Prevent the group from completing waypoints while the building is being searched
[QEGVAR(common,lockWP), [_group, true], _group] call CBA_fnc_targetEvent;

// Change the group's behaviour to that ideal for searching
private _leader = leader _group;
private _groupState = [formation _group, behaviour _leader, speedMode _group, combatMode _group];

[QEGVAR(common,setFormation), [_group, "FILE"], _group] call CBA_fnc_targetEvent;
[QEGVAR(common,setBehaviour), [_group, "COMBAT"], _group] call CBA_fnc_targetEvent;
[QEGVAR(common,setSpeedMode), [_group, "LIMITED"], _group] call CBA_fnc_targetEvent;
[QEGVAR(common,setCombatMode), [_group, "RED"], _group] call CBA_fnc_targetEvent;
[QEGVAR(common,setFormDir), [_group, _leader getDir _building], _group] call CBA_fnc_targetEvent;

// Make units stand up while they search the building
private _stances = [];

{
    if (alive _x && {isNull objectParent _x} && {!isPlayer _x}) then {
        _stances pushBack [_x, unitPos _x];
        [QEGVAR(common,setUnitPos), [_x, "UP"], _x] call CBA_fnc_targetEvent;
    };
} forEach units _group;

// Make the group search all building positions
[{
    params ["_group", "_positions"];

    // Refresh units in case some died or left/joined the group
    private _units = units _group select {
        alive _x && {isNull objectParent _x} && {!isPlayer _x}
    };

    // Exit the search if the group has no units left
    if (_units isEqualTo []) exitWith {true};

    // Repeatedly make all units that are ready search the remaining positions
    {
        if (_positions isEqualTo []) exitWith {};

        if (unitReady _x) then {
            private _position = _positions deleteAt 0;
            [QEGVAR(common,doMove), [_x, _position], _x] call CBA_fnc_targetEvent;
        };
    } forEach _units;

    // Exit if all positions have been searched
    _positions isEqualTo []
}, {
    params ["_group", "", "_groupState", "_stances"];

    // Wait until all units have finished searching
    [{
        params ["_group"];

        units _group findIf {alive _x && {!unitReady _x}} == -1
    }, {
        params ["_group", "_groupState", "_stances"];

        // Restore the group's behaviour
        _groupState params ["_formation", "_behaviour", "_speedMode", "_combatMode"];

        [QEGVAR(common,setFormation), [_group, _formation], _group] call CBA_fnc_targetEvent;
        [QEGVAR(common,setBehaviour), [_group, _behaviour], _group] call CBA_fnc_targetEvent;
        [QEGVAR(common,setSpeedMode), [_group, _speedMode], _group] call CBA_fnc_targetEvent;
        [QEGVAR(common,setCombatMode), [_group, _combatMode], _group] call CBA_fnc_targetEvent;

        // Restore unit stances
        {
            _x params ["_unit", "_stance"];
            [QEGVAR(common,setUnitPos), [_unit, _stance], _unit] call CBA_fnc_targetEvent;
        } forEach _stances;

        // Allow the group to complete waypoints again
        [QEGVAR(common,lockWP), [_group, false], _group] call CBA_fnc_targetEvent;
    }, [_group, _groupState, _stances]] call CBA_fnc_waitUntilAndExecute;
}, [_group, _positions, _groupState, _stances]] call CBA_fnc_waitUntilAndExecute;
