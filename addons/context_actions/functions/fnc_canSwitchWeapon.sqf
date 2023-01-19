#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if the given unit can switch to the selected weapon.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Weapon Index <NUMBER>
 *
 * Return Value:
 * Can Switch Weapon <BOOL>
 *
 * Example:
 * [_unit, 0] call zen_context_actions_fnc_canSwitchWeapon
 *
 * Public: No
 */

params ["_unit", "_weaponIndex"];

private _weapon = [primaryWeapon _unit, handgunWeapon _unit, binocular _unit] select _weaponIndex;

alive _unit
&& {!isPlayer _unit}
&& {_weapon != ""}
&& {_weapon != currentWeapon _unit}
