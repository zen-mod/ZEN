#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given entity is a vehicle whose appearance can be edited.
 *
 * Arguments:
 * 0: Entity <ANY>
 *
 * Return Value:
 * Can Edit Appearance <BOOL>
 *
 * Example:
 * [_entity] call zen_context_actions_fnc_canEditVehicleAppearance
 *
 * Public: No
 */

params ["_entity"];

_entity isEqualType objNull
&& {alive _entity}
&& {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}
