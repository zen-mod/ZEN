/*
 * Author: mharis001
 * Fixes disappearing side buttons when changing modes.
 * Called from ButtonClick EH.
 *
 * Arguments:
 * 0: Mode button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_editor_fnc_fixSideButtons
 *
 * Public: No
 */
#include "script_component.hpp"

// One frame later so RscDisplayCurator_sections is updated
[{
    params ["_ctrl"];

    private _display = ctrlParent _ctrl;
    RscDisplayCurator_sections params ["_mode"];

    // Get side buttons to show based on mode
    private _idcs = switch (_mode) do {
        case 0;
        case 1: {IDCS_SIDE_BUTTONS};
        case 2;
        case 3: {[IDC_RSCDISPLAYCURATOR_SIDEEMPTY]};
        default {[]}
    };

    {
        (_display displayCtrl _x) ctrlShow true;
    } forEach _idcs;
}, _this] call CBA_fnc_execNextFrame;
