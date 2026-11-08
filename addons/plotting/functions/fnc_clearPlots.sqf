#include "script_component.hpp"
/*
 * Authors: Timi007
 * Clears of plots.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_plotting_fnc_clearPlots
 *
 * Public: No
 */

GVAR(plots) = createHashMap;
GVAR(history) = [];
