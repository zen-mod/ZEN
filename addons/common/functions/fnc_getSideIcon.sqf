/*
 * Author: mharis001
 * Returns the side icon for given group or unit.
 *
 * Arguments:
 * 0: Unit <OBJECT|GROUP>
 *
 * Return Value:
 * Icon file path <STRING>
 *
 * Example:
 * [player] call zen_common_fnc_getSideIcon
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_group"];

if (_group isEqualType objNull) then {
    _group = group _group;
};

[ICON_OPFOR, ICON_BLUFOR, ICON_INDEPENDENT, ICON_CIVILIAN] select ([side _group] call BIS_fnc_sideID)
