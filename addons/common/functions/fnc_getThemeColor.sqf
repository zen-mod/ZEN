#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the GUI theme color.
 * Scripted equivalent to GUI_BCG_COLOR, which only works in config.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Theme Color <ARRAY>
 *
 * Example:
 * [] call zen_common_fnc_getThemeColor
 *
 * Public: No
 */

[
    profileNamespace getVariable ["GUI_BCG_RGB_R", 0.13],
    profileNamespace getVariable ["GUI_BCG_RGB_G", 0.54],
    profileNamespace getVariable ["GUI_BCG_RGB_B", 0.21],
    profileNamespace getVariable ["GUI_BCG_RGB_A", 0.8]
]
