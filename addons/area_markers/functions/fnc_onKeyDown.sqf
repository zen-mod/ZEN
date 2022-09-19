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
        deleteMarker _marker;
        true
    };

    false
};

// Map visibility can be toggled with the ESCAPE key
// Appears to be hard coded and independent of the "ingamePause" user action
// Also, update the icons when the interface's visibility is toggled
if (_keyCode == DIK_ESCAPE || {_keyCode in actionKeys "curatorToggleInterface"}) then {
    call FUNC(onMapToggled);
};

false
