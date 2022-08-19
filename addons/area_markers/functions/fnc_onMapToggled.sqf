#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles toggling the Zeus display's map.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_area_markers_fnc_onMapToggled
 *
 * Public: No
 */

if (isNull findDisplay IDD_RSCDISPLAYCURATOR) exitWith {};

// Need frame delay because both the visisbleMap and the map control's
// visibility are not updated until the next frame
{
    private _show = visibleMap && {!call EFUNC(common,isInScreenshotMode)};

    {
        _y ctrlShow _show;
    } forEach GVAR(icons);
} call CBA_fnc_execNextFrame;
