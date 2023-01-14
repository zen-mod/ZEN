#include "script_component.hpp"
/*
 * Author: mharis001, Kex
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

isClass (configFile >> "CfgPatches" >> "ace_fastroping")
&& {getNumber (configFile >> "CfgVehicles" >> _vehicle >> "ace_fastroping_enabled") > 0}
