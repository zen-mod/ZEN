#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the Zeus side buttons.
 *
 * Arguments:
 * 0: Side Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_editor_fnc_handleSideButtons
 *
 * Public: No
 */

params ["_ctrlButton"];

if !(_ctrlButton getVariable [QGVAR(hovered), false]) exitWith {};

private _display = ctrlParent _ctrlButton;

[{
    RscDisplayCurator_sections params ["_mode", "_side"];
    [QGVAR(sideChanged), [_this, _mode, _side]] call CBA_fnc_localEvent;
}, _display] call CBA_fnc_execNextFrame;
