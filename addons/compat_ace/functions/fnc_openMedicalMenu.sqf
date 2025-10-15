#include "script_component.hpp"
/*
 * Author: OverlordZorn
 * Opens ace medical menu for an unit.
 *
 * Arguments:
 * 0: Hovered Entity <OBJECT, GROUP,ARRAY, or STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_hoveredEntity] call zen_compat_ace_fnc_openMedicalMenu
 *
 * Public: No
 */

params ["_hoveredEntity"];

[_hoveredEntity] call ace_medical_gui_fnc_openMenu;
