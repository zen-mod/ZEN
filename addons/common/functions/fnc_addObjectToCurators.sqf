#include "script_component.hpp"
/*
 * Author: Glowbal
 * Handles automatically adding an object to all curators.
 * Used by the autoAddObjects setting.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object] call zen_common_fnc_addObjectToCurators
 *
 * Public: No
 */

params ["_object"];

if !(_object getVariable [QGVAR(autoAddObject), GVAR(autoAddObjects)]) exitWith {};

[{
    {
        _x addCuratorEditableObjects [[_this], true];
    } forEach allCurators;
}, _object] call CBA_fnc_execNextFrame;
