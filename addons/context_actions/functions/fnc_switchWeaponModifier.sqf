#include "script_component.hpp"
/*
 * Author: Ampersand
 * Modifies the switch weapon action based on the hovered entity.
 *
 * Arguments:
 * 0: Action <ARRAY>
 * 1: Action Parameters <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_action, _actionParams] call zen_context_actions_fnc_switchWeaponModifier
 *
 * Public: No
 */

params ["_action", "_actionParams"];
_action params ["", "", "", "", "", "", "_args"];
_actionParams params ["", "", "", "", "", "_hoveredEntity"];

private _weapon = [
    primaryWeapon _hoveredEntity,
    secondaryWeapon _hoveredEntity,
    handgunWeapon _hoveredEntity,
    binocular _hoveredEntity
] select _args;

private _cfgWeapons = configFile >> "CfgWeapons" >> _weapon;

private _displayName = getText (_cfgWeapons >> "displayName");

if (_displayName != "") then {
    _action set [1, _displayName];
};

private _picture = getText (_cfgWeapons >> "picture");

if (_picture != "") then {
    _action set [2, _picture];
};
