#include "script_component.hpp"
/*
 * Author: Ampersand
 * Switches the given unit's weapon to the selected one.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Weapon Index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, _weaponIndex] call zen_context_actions_fnc_switchWeapon
 *
 * Public: No
 */

params ["_unit", "_weaponIndex"];

private _weapon = [primaryWeapon _unit, handgunWeapon _unit, binocular _unit] select _weaponIndex;
[QEGVAR(common,selectWeapon), [_unit, _weapon], _unit] call CBA_fnc_targetEvent;
