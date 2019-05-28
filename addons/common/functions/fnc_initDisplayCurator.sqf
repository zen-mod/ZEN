/*
 * Author: mharis001
 * Initializes the Zeus Display and emits relevant events.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_common_fnc_initDisplayCurator
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display"];

private _module = getAssignedCuratorLogic player;

// Remove "Gear" animation when entering Zeus
if (GVAR(disableGearAnim) && {vehicle player == player}) then {
    [{player switchMove _this}, animationState player] call CBA_fnc_execNextFrame;
};

// Emit one time module setup event
if !(_module getVariable [QGVAR(setupComplete), false]) then {
    ["ZEN_moduleSetup", _module] call CBA_fnc_localEvent;
    _module setVariable [QGVAR(setupComplete), true];
};

// Emit display load event
["ZEN_displayCuratorLoad", _display] call CBA_fnc_localEvent;
