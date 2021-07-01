#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the Zeus mode buttons.
 *
 * Arguments:
 * 0: Mode Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_editor_fnc_handleModeButtons
 *
 * Public: No
 */


params ["_ctrlButton"];

private _display = ctrlParent _ctrlButton;

[{
    RscDisplayCurator_sections params ["_mode", "_side"];
    [QGVAR(modeChanged), [_this, _mode, _side]] call CBA_fnc_localEvent;
}, _display] call CBA_fnc_execNextFrame;
