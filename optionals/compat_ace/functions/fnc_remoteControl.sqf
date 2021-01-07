#include "script_component.hpp"
/*
 * Author: mharis001
 * Remote controls a unit from the currently selected objects.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_compat_ace_fnc_remoteControl
 *
 * Public: No
 */

private _unit = SELECTED_OBJECTS param [SELECTED_OBJECTS findIf {_x call EFUNC(remote_control,canControl)}, objNull];
if (isNull _unit) exitWith {};

[_unit] call EFUNC(remote_control,start);
