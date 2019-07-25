/*
 * Author: mharis001, 3Mydlo3
 * Teleports Zeus to the given position or vehicle.
 *
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0]] call zen_context_actions_fnc_teleportZeus
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_posASL"];

private _curatorHovered = curatorMouseOver;
_curatorHovered params ["_type", "_entity"];

if (_type isEqualTo "OBJECT") then {
    private _result = [[player], _entity] call EFUNC(common,teleportToVehicle);
    if (_result) exitWith {};
    [localize "str_3den_notifications_vehiclefull_text"] call EFUNC(common,showMessage);
} else {
    player setPosASL _posASL;
};
