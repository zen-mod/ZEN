#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the Zeus display is in marker editing mode.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * In Marker Editing Mode <BOOL>
 *
 * Example:
 * [] call zen_area_markers_fnc_isInEditMode
 *
 * Public: No
 */

visibleMap
&& {!dialog}
&& {!call EFUNC(common,isInScreenshotMode)}
&& {RscDisplayCurator_sections select 0 == 3}
