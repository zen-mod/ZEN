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

if (!GVAR(interfaceShown) || {_button == 1}) then {
    [] call FUNC(toggleInterface);
};
