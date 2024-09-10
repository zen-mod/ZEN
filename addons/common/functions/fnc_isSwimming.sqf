#include "script_component.hpp"
/*
 * Author: das attorney, Jonpas
 * Checks if the given unit is swimming (surface swimming or diving).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Is Swimming <BOOL>
 *
 * Example:
 * [_unit] call zen_common_fnc_isSwimming
 *
 * Public: Yes
 */

params [["_unit", objNull, [objNull]]];

animationState _unit select [1, 3] in ["bdv", "bsw", "dve", "sdv", "ssw", "swm"]
