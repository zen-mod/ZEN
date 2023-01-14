#include "script_component.hpp"
/*
 * Author: Kex
 * Checks if the given vehicle has fastroping.
 *
 * Arguments:
 * 0: Vehicle <OBJECT|STRING>
 *
 * Return Value:
 * Has fastroping <BOOL>
 *
 * Example:
 * [_vehicle] call zen_common_fnc_hasFastroping
 *
 * Public: No
 */

params ["_vehicle"];

if (_vehicle isEqualType objNull) then {
    _vehicle = typeOf _vehicle;
};

if (isNil "AR_RAPPELLING_INIT") exitWith {false};

(missionNamespace getVariable ["AR_SUPPORTED_VEHICLES_OVERRIDE", AR_SUPPORTED_VEHICLES]) findIf {_vehicle isKindOf _x} >= 0
