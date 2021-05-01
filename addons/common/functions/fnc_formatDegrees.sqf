#include "script_component.hpp"
/*
 * Author: mharis001
 * Formats the given number into a string with the degree symbol.
 *
 * Arguments:
 * 0: Degrees <NUMBER>
 *
 * Return Value:
 * Formatted String <STRING>
 *
 * Example:
 * [90] call zen_common_fnc_formatDegrees
 *
 * Public: No
 */

params [["_degrees", 0, [0]]];

format ["%1%2", round _degrees, toString [ASCII_DEGREE]]
