#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles the display load event for the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_common_fnc_displayCuratorLoad
 *
 * Public: No
 */

params ["_display"];

// Remove "Gear" animation when entering Zeus
if (GVAR(disableGearAnim) && {vehicle player == player}) then {
    [{player switchMove _this}, animationState player] call CBA_fnc_execNextFrame;
};

// Track mouse position from mouse area control to handle the mouse being over other UI elements
// RscDisplayCurator_mousePos from base game attempts to do this but for some reason also updates when
// the mouse is over the mission controls group
private _fnc_updateMousePos = {
    params ["", "_posX", "_posY"];
    GVAR(mousePos) = [_posX, _posY];
};

private _ctrlMouseArea = _display displayCtrl IDC_RSCDISPLAYCURATOR_MOUSEAREA;
_ctrlMouseArea ctrlAddEventHandler ["MouseMoving", _fnc_updateMousePos];
_ctrlMouseArea ctrlAddEventHandler ["MouseHolding", _fnc_updateMousePos];

// Emit display load event
["zen_curatorDisplayLoaded", _display] call CBA_fnc_localEvent;
