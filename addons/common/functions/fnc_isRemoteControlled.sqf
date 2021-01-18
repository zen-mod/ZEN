#include "script_component.hpp"
/*
 * Author: NeilZar
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Unit is Remote Controlled <BOOL>
 *
 * Example:
 * [cursorObject] call zen_common_fnc_isRemoteControlled
 *
 * Public: Yes
 */

params ["_unit"];

if !(_unit isKindOf "CAManBase") exitWith {false};

allCurators findIf {_x getVariable "bis_fnc_moduleremotecontrol_unit" isEqualTo _unit} != -1
