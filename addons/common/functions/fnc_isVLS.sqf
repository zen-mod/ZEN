#include "script_component.hpp"
/*
 * Author: Kex
 * Checks if the given vehicle is a VLS.
 *
 * Arguments:
 * 0: Vehicle <OBJECT|STRING>
 *
 * Return Value:
 * Is VLS <BOOL>
 *
 * Example:
 * [_vehicle] call zen_common_fnc_isVLS
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull, ""]]];

_vehicle isKindOf VLS_BASE_CLASS
