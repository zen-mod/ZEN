#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given vehicle has configurable pylons.
 *
 * Arguments:
 * 0: Vehicle <OBJECT|STRING>
 *
 * Return Value:
 * Has Pylons <BOOL>
 *
 * Example:
 * [_vehicle] call zen_common_fnc_hasPylons
 *
 * Public: No
 */

params ["_vehicle"];

if (_vehicle isEqualType objNull) then {
    _vehicle = typeOf _vehicle;
};

isClass (configFile >> "CfgVehicles" >> _vehicle >> "Components" >> "TransportPylonsComponent")
