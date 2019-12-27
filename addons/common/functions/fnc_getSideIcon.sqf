#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the side icon for given group or unit.
 *
 * Arguments:
 * 0: Unit or Group <OBJECT|GROUP>
 *
 * Return Value:
 * Icon File Path <STRING>
 *
 * Example:
 * [player] call zen_common_fnc_getSideIcon
 *
 * Public: No
 */

params ["_group"];

if (_group isEqualType objNull) then {
    _group = group _group;
};

[ICON_OPFOR, ICON_BLUFOR, ICON_INDEPENDENT, ICON_CIVILIAN] select ([side _group] call BIS_fnc_sideID)
