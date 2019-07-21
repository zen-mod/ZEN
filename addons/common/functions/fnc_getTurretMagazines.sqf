#include "script_component.hpp"
/*
 * Author: GitHawk, Jonpas
 * Returns all magazines a vehicle turret can hold according to config.
 *
 * Arguments:
 * 0: Vehicle <OBJECT|STRING>
 * 1: Turret Path <ARRAY>
 *
 * Return Value:
 * Magazines <ARRAY>
 *
 * Example:
 * [vehicle player, [-1]] call zen_common_fnc_getTurretMagazines
 *
 * Public: No
 */

getArray ((_this call CBA_fnc_getTurret) >> "magazines")
