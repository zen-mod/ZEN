#include "script_component.hpp"
/*
 * Author: OverlordZorn
 * Checks if the ace medical menu can be opened for an unit.
 *
 * Arguments:
 * 0: Hovered Entity <OBJECT, GROUP,ARRAY, or STRING>
 *
 * Return Value:
 * Can Open ACE Medical Menu <BOOL>
 *
 * Example:
 * [_hoveredEntity] call zen_compat_ace_fnc_canOpenMedicalMenu
 *
 * Public: No
 */

params ["_hoveredEntity"];


switch (false) do {
    case (_hoveredEntity isEqualType objNull): { false };
    case (!isNull _hoveredEntity): { false };
    case (_hoveredEntity isKindOf "CAManBase"): { false };
    case (["ace_medical_gui"] call ace_common_fnc_isModLoaded): { false };
    case ([objNull, _hoveredEntity] call ace_medical_gui_fnc_canOpenMenu): { false };
} // returns true when no match and no default case
