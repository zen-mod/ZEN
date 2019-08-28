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

EXIT_LOCKED;

params ["_ctrlButton"];

private _display = ctrlParent _ctrlButton;
private _mode = GETMVAR(RscDisplayCurator_sections,[]) param [0, 0];
private _side = IDCS_SIDE_BUTTONS find ctrlIDC _ctrlButton;

[QGVAR(sideChanged), [_display, _mode, _side]] call CBA_fnc_localEvent;
