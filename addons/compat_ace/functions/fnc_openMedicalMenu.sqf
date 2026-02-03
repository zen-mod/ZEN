#include "script_component.hpp"
/*
 * Author: OverlordZorn
 * Opens ace medical menu for an unit.
 *
 * Arguments:
 * 0: Entity <ANY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_entity] call zen_compat_ace_fnc_openMedicalMenu
 *
 * Public: No
 */

params ["_entity"];

[_entity] call ACEFUNC(medical_gui,openMenu);
