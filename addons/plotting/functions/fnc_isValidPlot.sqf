#include "script_component.hpp"
/*
 * Authors: Timi007
 * Checks if the given plot identified by an ID is still valid.
 *
 * Arguments:
 * 0: Plot ID <NUMBER>
 *
 * Return Value:
 * Plot is valid <BOOL>
 *
 * Example:
 * [1] call zen_plotting_fnc_isValidPlot
 *
 * Public: No
 */

params ["_id"];

if !(_id in GVAR(plots)) exitWith {false};

(GVAR(plots) get _id) params ["", "_startPos", "_endPos"];

(_startPos isNotEqualTo objNull)
&& {_endPos isNotEqualTo objNull}
