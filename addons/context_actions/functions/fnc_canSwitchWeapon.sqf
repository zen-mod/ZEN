#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if the given unit has multiple weapons to switch between.
 *
 * Arguments:
 * 0: Entity <ANY>
 *
 * Return Value:
 * Can Switch Weapon <BOOL>
 *
 * Example:
 * [_entity, 0] call zen_context_actions_fnc_canSwitchWeapon
 *
 * Public: No
 */

params ["_entity", "_weaponIndex"];

private _weapon = [primaryWeapon _entity, handgunWeapon _entity, binocular _entity] select _weaponIndex;

_entity isEqualType objNull
&& {alive _entity}
&& {!isPlayer _entity}
&& {_weapon != ""}
&& {_weapon != currentWeapon _entity}
