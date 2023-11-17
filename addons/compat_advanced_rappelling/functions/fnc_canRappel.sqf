#include "script_component.hpp"
/*
 * Author: Kex
 * Checks if the given vehicle can be used for rappelling.
 *
 * Arguments:
 * 0: Vehicle <OBJECT|STRING>
 *
 * Return Value:
 * Can Rappel <BOOL>
 *
 * Example:
 * [_vehicle] call zen_compat_advanced_rappelling_fnc_canRappel
 *
 * Public: No
 */

params ["_vehicle"];

!isNil "AR_RAPPELLING_INIT" && {
    private _supportedVehicles = missionNamespace getVariable ["AR_SUPPORTED_VEHICLES_OVERRIDE", AR_SUPPORTED_VEHICLES];
    _supportedVehicles findIf {_vehicle isKindOf _x} != -1
}
