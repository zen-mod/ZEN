/*
 * Author: 3Mydlo3, veteran29
 * Heals units in given selection. Works for units in vehicles.
 * Healing modes:
 * HEAL_MODE_ALL - 0
 * HEAL_MODE_AI - 1
 * HEAL_MODE_PLAYERS - 2
 *
 * Arguments:
 * 0: Selected Objects <ARRAY>
 * 1: Mode <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[player1, player2, player3], 2] call zen_context_actions_fnc_healUnits
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_objects", "_mode"];

private _units = [];
{
    _units append crew _x;
} forEach _objects;

private _fnc_filter = [{true}, {!isPlayer _this}, {isPlayer _this}] select _mode;

{
    if (alive _x && {_x call _fnc_filter}) then {
        [_x] call EFUNC(common,healUnit);
    };
} forEach (_units arrayIntersect _units);
