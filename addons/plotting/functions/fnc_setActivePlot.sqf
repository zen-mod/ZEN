#include "script_component.hpp"
/*
 * Authors: Timi007
 * Sets the currently active plot where the end position is attached to the cursor.
 *
 * Arguments:
 * 0: Type of plot <STRING>
 * 1: Start position ASL or attached object <ARRAY or OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["LINE", curatorCamera] call zen_plotting_fnc_setActivePlot
 *
 * Public: No
 */

params [["_type", "LINE", [""]], ["_startPos", [0, 0, 0], [[], objNull], [3]]];

GVAR(activePlot) = [_type, _startPos];

