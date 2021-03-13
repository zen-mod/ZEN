#include "script_component.hpp"
/*
 * Author: NeilZar
 * Checks if the loadout of the given entity can be edited.
 *
 * Arguments:
 * 0: Entity <ANY>
 *
 * Return Value:
 * Can Edit Loadout <BOOL>
 *
 * Example:
 * [_entity] call zen_context_actions_fnc_canEditLoadout
 *
 * Public: No
 */

params ["_entity"];

_entity isEqualType objNull && {alive _entity} && {_entity call EFUNC(common,hasPylons)}
