#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handles placement of an object by Zeus.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Placed Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _object] call zen_building_markers_fnc_handleObjectPlaced
 *
 * Public: No
 */

params ["", "_object"];

if (GVAR(enabled) && {_object isKindOf "Building"}) then {
    [QGVAR(set), [_object, true]] call CBA_fnc_serverEvent;
};
