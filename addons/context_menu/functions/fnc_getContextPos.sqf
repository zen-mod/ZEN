#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the position where context menu was opened.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Position ASL <ARRAY>
 *
 * Example:
 * [] call zen_context_menu_fnc_getContextPos
 *
 * Public: No
 */

// Handle using context on map screen
if (visibleMap) exitWith {
    private _ctrlMap = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    private _pos2D = _ctrlMap ctrlMapScreenToWorld GVAR(mousePos);
    _pos2D + [getTerrainHeightASL _pos2D]
};

AGLtoASL screenToWorld GVAR(mousePos)
