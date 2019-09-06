#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles placement of an object by Zeus.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Placed object <OBJECT>
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

if (!GVAR(includeCrew) && {RscDisplayCurator_sections select 0 == 0}) then {
    TRACE_2("Deleting crew",_object,crew _object);
    {_object deleteVehicleCrew _x} forEach crew _object;
};
