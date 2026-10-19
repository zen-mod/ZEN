#include "script_component.hpp"
/*
 * Author: Kex
 * Checks if the given vehicle can be used for fastroping.
 *
 * Arguments:
 * 0: Vehicle <OBJECT|STRING>
 *
 * Return Value:
 * Can Fastrope <BOOL>
 *
 * Example:
 * [_vehicle] call zen_compat_ace_fnc_canFastrope
 *
 * Public: No
 */

params ["_vehicle"];

if (_vehicle isEqualType objNull) then {
    _vehicle = typeOf _vehicle;
};

isClass (configFile >> "CfgPatches" >> "ace_fastroping")
&& {getNumber (configFile >> "CfgVehicles" >> _vehicle >> QACEGVAR(fastroping,enabled)) > 0}
