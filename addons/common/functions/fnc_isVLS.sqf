#include "script_component.hpp"
/*
 * Author: Kex
 * Checks whether the vehicle is a VLS.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Is VLS <BOOL>
 *
 * Example:
 * [vehicle player] call zen_common_fnc_isVLS
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]]];

_vehicle isKindOf CLASS_VLS_BASE
