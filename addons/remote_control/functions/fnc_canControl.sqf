#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given entity can be remote controlled.
 *
 * Arguments:
 * 0: Entity <ANY>
 *
 * Return Value:
 * Can Remote Control <BOOL>
 *
 * Example:
 * [_unit] call zen_remote_control_fnc_canControl
 *
 * Public: No
 */

params ["_entity"];

if !(_entity isEqualType objNull) exitWith {false};

private _unit = effectiveCommander _entity;

alive _unit
&& {!isPlayer _unit}
&& {side group _unit in [west, east, independent, civilian]}
&& {isNull (_unit getVariable [VAR_OWNER, objNull])}
&& {!isUAVConnected vehicle _unit}
