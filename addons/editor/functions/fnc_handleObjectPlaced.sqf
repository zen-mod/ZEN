#include "script_component.hpp"
/*
 * Author: mharis001
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
 * [_logic, _object] call zen_editor_fnc_handleObjectPlaced
 *
 * Public: No
 */

params ["", "_object"];

RscDisplayCurator_sections params ["_mode"];

if (!GVAR(includeCrew) && {_mode == 0 || {_mode == 4 && {isClass (configFile >> "CfgVehicles" >> GVAR(recentTreeData))}}}) then {
    TRACE_2("Deleting crew",_object,crew _object);
    {_object deleteVehicleCrew _x} forEach crew _object;
};
