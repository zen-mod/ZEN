#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles drawing the comments on the Zeus map. Is only called when map is open.
 *
 * Arguments:
 * 0: Zeus map <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_mapCtrl] call zen_comments_fnc_onDraw
 *
 * Public: No
 */

BEGIN_COUNTER(onDraw);

params ["_mapCtrl"];

if (!GVAR(enabled) && !GVAR(enabled3DEN)) exitWith {
    _mapCtrl ctrlRemoveEventHandler [_thisEvent, _thisEventHandler];
    LOG("Removed 3DENComments map draw.");
};

if (dialog || {call EFUNC(common,isInScreenshotMode)}) exitWith {}; // Dialog is open or HUD is hidden

[GVAR(comments), GVAR(icons), GVAR(enabled), GVAR(enabled3DEN), _mapCtrl] call FUNC(drawComments);

END_COUNTER(onDraw);
