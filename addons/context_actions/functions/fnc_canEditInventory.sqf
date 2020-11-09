#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the inventory of the given entity can be edited.
 *
 * Arguments:
 * 0: Entity <ANY>
 *
 * Return Value:
 * Can Edit Inventory <BOOL>
 *
 * Example:
 * [_entity] call zen_context_actions_fnc_canEditInventory
 *
 * Public: No
 */

params ["_entity"];

_entity isEqualType objNull
&& {alive _entity}
&& {getNumber (configOf _entity >> "maximumLoad") > 0}
