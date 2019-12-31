#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns all lighting hitpoints of the given object.
 *
 * Arguments:
 * 0: Object <OBJECT|STRING>
 *
 * Return Value:
 * Selections <ARRAY>
 *
 * Example:
 * [_object] call zen_common_fnc_getLightingSelections
 *
 * Public: No
 */

params ["_object"];

if (_object isEqualType objNull) then {
    _object = typeOf _object;
};

configProperties [configFile >> "CfgVehicles" >> _object >> "Reflectors", "isClass _x"] apply {
    getText (_x >> "hitpoint")
}
