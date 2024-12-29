#include "script_component.hpp"
/*
 * Author: Timi007
 * Checks if we can/should draw 3D icons in Zeus.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Can draw 3D icons. <BOOLEAN>
 *
 * Example:
 * call zen_comments_fnc_canDraw3DIcons
 *
 * Public: No
 */

(!isNull (findDisplay IDD_RSCDISPLAYCURATOR)) &&    // We are in Zeus
{isNull (findDisplay IDD_INTERRUPT)} &&             // Pause menu is not opened
{!(call EFUNC(common,isInScreenshotMode))}          // HUD is not hidden
