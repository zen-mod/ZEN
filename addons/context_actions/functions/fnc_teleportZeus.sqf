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

if (_hoveredEntity isEqualType objNull && {_hoveredEntity isKindOf "AllVehicles"} && {!(_hoveredEntity isKindOf "CAManBase")}) then {
    [[player], _hoveredEntity] call EFUNC(common,teleportIntoVehicle);
} else {
    player setPosASL _contextPosASL;
};
