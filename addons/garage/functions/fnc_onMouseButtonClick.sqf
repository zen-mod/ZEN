#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles the MouseButtonClick event for the garage display.
 *
 * Arguments:
 * 0: Mouse Area (not used) <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 1] call zen_garage_fnc_onMouseButtonClick
 *
 * Public: No
 */

params ["", "_button"];

if (_button == 1 || {!GVAR(interfaceShown)}) exitWith {
    [] call FUNC(toggleInterface);
};

if (_button == 0 && {GVAR(interfaceShown)} && {GVAR(currentTab) != -1} && {GVAR(mouseButtons) isEqualTo [[], []]}) exitWith {
    [-1] call FUNC(onTabSelect);
};
