#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if the given unit has multiple weapons to switch between.
 *
 * Arguments:
 * 0: UNIT <OBJECT>
 * 1: WEAPON INDEX <NUMBER>
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

_unit isEqualType objNull
&& {alive _unit}
&& {!isPlayer _unit}
&& {_weapon != ""}
&& {_weapon != currentWeapon _unit}
