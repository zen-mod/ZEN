#include "script_component.hpp"
/*
 * Author: mharis001
 * Fixes disappearing side buttons when changing modes.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Mode <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, 0] call zen_editor_fnc_fixSideButtons
 *
 * Public: No
 */

[{
    params ["_display", "_mode"];

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
