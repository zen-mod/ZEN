#include "script_component.hpp"
/*
 * Author: Ampersand
 * Updates switch weapon actions.
 *
 * Arguments:
 * 0: UNIT <OBJECT>
 * 1: WEAPON INDEX <NUMBER>
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
['zen_common_selectWeapon', [_unit, _weapon], _unit] call CBA_fnc_targetEvent;
