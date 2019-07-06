#include "script_component.hpp"
/*
 * Author: Kex
 * Gets triggered when Zeus placed a module (child of Module_F).
 * Fixes activation of copy/pasted modules.
 *
 * Arguments:
 * 0: Curator module (not used) <OBJECT>
 * 1: Placed module <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _module] call ZEN_fnc_handleModulePlaced
 *
 * Public: No
 */

params ["", "_module"];

if !(_module isKindOf QGVAR(moduleBase)) then {
    _module setVariable ["BIS_fnc_initModules_activate", true, true];
};
