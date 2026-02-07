#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles drawing the comments in Zeus 3D.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call zen_comments_fnc_onDraw3D
 *
 * Public: No
 */

BEGIN_COUNTER(onDraw3D);

if (!GVAR(enabled) && !GVAR(enabled3DEN)) exitWith {
    removeMissionEventHandler [_thisEvent, _thisEventHandler];

    {ctrlDelete _y} forEach GVAR(icons);
    GVAR(icons) = createHashMap;

    GVAR(draw3DAdded) = false;
    LOG("Removed Draw3D.");
};

if (
    isNull (findDisplay IDD_RSCDISPLAYCURATOR) ||   // We are in not Zeus
    {!isNull (findDisplay IDD_INTERRUPT)} ||        // Pause menu is opened
    {dialog} ||                                     // We have a dialog open
    {call EFUNC(common,isInScreenshotMode)}         // HUD is hidden
) exitWith {
    {_y ctrlShow false} forEach GVAR(icons);
};

[GVAR(comments), GVAR(icons), GVAR(enabled), GVAR(enabled3DEN)] call FUNC(drawComments);

END_COUNTER(onDraw3D);
