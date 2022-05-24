#include "script_component.hpp"
/*
 * Author: mjc4wilton
 * Returns the given unit's loadout, uses CBA Extended Loadouts
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Unit Loadout Array <ARRAY>
 *
 * Example:
 * [_unit] call zen_common_fnc_getUnitLoadout
 *
 * Public: No
 */

params ["_unit"];

[_unit] call CBA_fnc_getLoadout
