#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles drawing the plots in Zeus 3D.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call zen_plotting_fnc_onDraw3D
 *
 * Public: No
 */

BEGIN_COUNTER(onDraw3D);

if (
    isNull (findDisplay IDD_RSCDISPLAYCURATOR) ||   // We are in not Zeus
    {!isNull (findDisplay IDD_INTERRUPT)} ||        // Pause menu is opened
    {dialog} ||                                     // We have a dialog open
    {call EFUNC(common,isInScreenshotMode)}         // HUD is hidden
) exitWith {};

[GVAR(plots), GVAR(activePlot)] call FUNC(drawPlots);

END_COUNTER(onDraw3D);
