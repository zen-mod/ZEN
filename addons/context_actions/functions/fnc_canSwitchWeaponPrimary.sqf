#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if the given unit can switch to primary weapon.
 *
 * Arguments:
 * 0: Entity <ANY>
 *
 * Return Value:
 * Can Switch Weapon <BOOL>
 *
 * Example:
 * [_entity] call zen_context_actions_fnc_canSwitchWeaponPrimary
 *
 * Public: No
 */

params ["_entity"];

_entity isEqualType objNull
&& {alive _entity}
&& {!isPlayer _entity}
&& {primaryWeapon _entity != '' }
&& {primaryWeapon _entity != currentWeapon _entity}
