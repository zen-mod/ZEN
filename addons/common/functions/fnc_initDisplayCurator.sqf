/*
 * Author: mharis001
 * Initializes the Zeus Display and emits relevant events.
 *
 * Arguments:
 * 0: Zeus Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_common_fnc_initZeusDisplay
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display"];

private _module = getAssignedCuratorLogic player;

// Emit one time module setup event
if !(_module getVariable [QGVAR(setupComplete), false]) then {
    [QGVAR(moduleSetup), _module] call CBA_fnc_localEvent;
    _module setVariable [QGVAR(setupComplete), true];
};

// Emit display load event
[QGVAR(zeusDisplayLoad), _display] call CBA_fnc_localEvent;
