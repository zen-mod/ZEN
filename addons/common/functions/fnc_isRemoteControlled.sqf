#include "script_component.hpp"
/*
 * Author: NeilZar
 * Check whether the given unit is currently remote controlled.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Unit is Remote Controlled <BOOL>
 *
 * Example:
 * [_unit] call zen_common_fnc_isRemoteControlled
 *
 * Public: Yes
 */

params ["_unit"];

if !(_unit isKindOf "CAManBase") exitWith {false};

_unit getVariable ["bis_fnc_moduleremotecontrol_owner", objNull] in allCurators
