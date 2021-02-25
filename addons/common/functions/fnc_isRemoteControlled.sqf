#include "script_component.hpp"
/*
 * Author: NeilZar
 * Checks if the given unit is currently remote controlled.
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

!isNull (_unit getVariable ["bis_fnc_moduleremotecontrol_owner", objNull])
