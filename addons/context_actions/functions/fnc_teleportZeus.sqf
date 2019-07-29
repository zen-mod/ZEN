#include "script_component.hpp"
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

params ["_posASL"];

curatorMouseOver params ["_type", "_entity"];

if (_type isEqualTo "OBJECT" && {_entity isKindOf "AllVehicles"} && {!(_entity isKindOf "CAManBase")}) then {
    [[player], _entity] call EFUNC(common,teleportIntoVehicle);
} else {
    player setPosASL _posASL;
};
