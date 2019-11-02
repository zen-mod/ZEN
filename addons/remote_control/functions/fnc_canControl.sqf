#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the hovered entity can be remote controlled.
 *
 * Arguments:
 * 0: Hovered Entity <OBJECT|GROUP|ARRAY|STRING>
 *
 * Return Value:
 * Can Remote Control <BOOL>
 *
 * Example:
 * [_hoveredEntity] call zen_remote_control_fnc_canControl
 *
 * Public: No
 */

params ["_hoveredEntity"];

if !(_hoveredEntity isEqualType objNull) exitWith {false};

private _unit = effectiveCommander _hoveredEntity;

alive _unit
&& {!isPlayer _unit}
&& {side group _unit in [west, east, independent, civilian]}
&& {isNull (_unit getVariable [VAR_OWNER, objNull])}
&& {!isUAVConnected vehicle _unit}
