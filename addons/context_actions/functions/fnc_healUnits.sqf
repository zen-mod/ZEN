#include "script_component.hpp"
/*
 * Author: 3Mydlo3, veteran29
 * Heals infantry units from the given objects list based on the mode.
 * Handles healing units currently in vehicles.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: Mode (0 - All, 1 - Players, 2 - AI) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_objects, 2] call zen_context_actions_fnc_healUnits
 *
 * Public: No
 */

params ["_objects", "_mode"];

private _units = [];

{
    _units append crew _x;
} forEach _objects;

private _fnc_filter = [{true}, {isPlayer _x}, {!isPlayer _x}] select _mode;

{
    if (alive _x && {_x isKindOf "CAManBase"} && _fnc_filter) then {
        _x call EFUNC(common,healUnit);
    };
} forEach (_units arrayIntersect _units);
