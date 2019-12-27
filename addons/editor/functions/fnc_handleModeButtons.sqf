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

[{
    params ["_ctrlButton"];

    private _display = ctrlParent _ctrlButton;
    private _mode = IDCS_MODE_BUTTONS find ctrlIDC _ctrlButton;
    private _side = GETMVAR(RscDisplayCurator_sections,[]) param [1, 0];

    [QGVAR(modeChanged), [_display, _mode, _side]] call CBA_fnc_localEvent;
}, _this] call CBA_fnc_execNextFrame;
