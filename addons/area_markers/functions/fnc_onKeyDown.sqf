#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles keyboard input for the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Key Code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, 0] call zen_area_markers_fnc_onKeyDown
 *
 * Public: No
 */

params ["_display", "_keyCode"];

if (visibleMap && {_keyCode == DIK_DELETE}) exitWith {
    private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    ctrlMapMouseOver _ctrlMap params [["_type", ""], ["_marker", ""]];

    if (_type == "marker" && {_marker in GVAR(markers)}) exitWith {
        [QGVAR(delete), _marker] call CBA_fnc_serverEvent;
        true
    };

    false
};

false
