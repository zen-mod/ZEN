#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given unit can throw a grenade.
 * When specified, also checks if the unit has the given grenade magazine.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Grenade Magazine <STRING> (default: "")
 *
 * Return Value:
 * Can Throw Grenade <BOOL>
 *
 * Example:
 * [_unit, "HandGrenade"] call zen_ai_fnc_canThrowGrenade
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_magazine", "", [""]]];

alive _unit
&& {!isPlayer _unit}
&& {isNull objectParent _unit}
&& {_unit isKindOf "CAManBase"}
&& {lifeState _unit in ["HEALTHY", "INJURED"]}
&& {!(_unit call EFUNC(common,isSwimming))}
&& {_magazine == "" || {_magazine in magazines _unit}}
