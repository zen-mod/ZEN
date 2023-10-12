#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles moving the mouse on the map.
 *
 * Arguments:
 * 0: Map <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_markers_tree_fnc_handleMouseMoving
 *
 * Public: No
 */

params ["_ctrlMap"];

if (_ctrlMap getVariable [QGVAR(holdingLMB), false]) then {
    _ctrlMap setVariable [QGVAR(holdingLMB), false];
};
