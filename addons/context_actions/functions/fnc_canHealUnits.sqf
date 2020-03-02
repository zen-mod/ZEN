#include "script_component.hpp"
/*
 * Author: 3Mydlo3, veteran29
 * Checks if infantry units from the given objects list can be healed based on the mode.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: Mode (0 - All, 1 - Players, 2 - AI) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_objects, 2] call zen_context_actions_fnc_canHealUnits
 *
 * Public: No
 */

params ["_objects", "_mode"];

private _fnc_filter = [{true}, {isPlayer _x}, {!isPlayer _x}] select _mode;

_objects findIf {crew _x findIf {alive _x && {_x isKindOf "CAManBase"} && _fnc_filter} != -1} != -1
