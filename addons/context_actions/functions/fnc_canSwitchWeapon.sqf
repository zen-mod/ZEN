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
 * [_entity] call zen_context_actions_fnc_canSwitchWeapon
 *
 * Public: No
 */

params ["_entity"];

_entity isEqualType objNull
&& {alive _entity}
&& {!isPlayer _entity}
&& {{_x != ""} count [primaryWeapon _hoveredEntity, handgunWeapon _hoveredEntity, binocular _hoveredEntity] >= 2}
