#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles keyboard input for the inventory attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Key Code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, 0] call zen_inventory_fnc_keyDown
 *
 * Public: No
 */

params ["_display", "_keyCode"];

// Exit if list is not in focus
private _controlsGroup = _display getVariable QGVAR(listFocus);
if (isNil "_controlsGroup") exitWith {false};

switch (_keyCode) do {
    case DIK_LEFT;
    case DIK_NUMPADMINUS: {
        [_controlsGroup, false] call FUNC(modify);
        true
    };
    case DIK_RIGHT;
    case DIK_NUMPADPLUS: {
        [_controlsGroup, true] call FUNC(modify);
        true
    };
    default {false};
};
