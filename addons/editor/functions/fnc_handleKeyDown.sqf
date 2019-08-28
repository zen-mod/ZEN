#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles the key down event for the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Key Code <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, 0] call zen_editor_fnc_handleKeyDown
 *
 * Public: No
 */

// One frame later so RscDisplayCurator_sections is updated
[{
    params ["_args", "_oldMode"];
    _args params ["_display", "_keyCode"];

    if (_keyCode == DIK_TAB) then {
        RscDisplayCurator_sections params ["_mode", "_side"];

        if (_mode != _oldMode) then {
            [QGVAR(modeChanged), [_display, _mode, _side]] call CBA_fnc_localEvent;
        };
    };
}, [_this, RscDisplayCurator_sections select 0]] call CBA_fnc_execNextFrame;

false
