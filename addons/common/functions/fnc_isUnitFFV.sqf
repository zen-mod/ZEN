#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given unit is in a FFV turret.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Is Unit FFV <BOOL>
 *
 * Example:
 * [_unit] call zen_common_fnc_isUnitFFV
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]]];

fullCrew vehicle _unit select {_x select 0 == _unit} param [0, []] param [4, false]
