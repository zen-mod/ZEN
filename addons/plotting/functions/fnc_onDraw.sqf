#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles drawing the plots on the Zeus map. Is only called when map is open.
 *
 * Arguments:
 * 0: Zeus map <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrlMap] call zen_plotting_fnc_onDraw
 *
 * Public: No
 */

BEGIN_COUNTER(onDraw);

params ["_ctrlMap"];

if (!GVAR(enabled)) exitWith {
    _ctrlMap ctrlRemoveEventHandler [_thisEvent, _thisEventHandler];
    LOG("Removed 3DENComments map draw.");
};

if (dialog || {call EFUNC(common,isInScreenshotMode)}) exitWith {}; // Dialog is open or HUD is hidden

[values GVAR(plots), GVAR(activePlot), _ctrlMap] call FUNC(drawPlots);

END_COUNTER(onDraw);
