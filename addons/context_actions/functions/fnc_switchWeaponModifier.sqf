#include "script_component.hpp"
/*
 * Author: Ampersand
 * Updates switch weapon actions.
 *
 * Arguments:
 * 0: Action <ARRAY>
 * 1: Action Params <ARRAY>
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

diag_log _this;
_action params ["", "", "", "", "", "", "_args"];
diag_log "_args";
diag_log _args;
_actionParams params ["", "", "", "", "", "_hoveredEntity"];
diag_log "_hoveredEntity";
diag_log _hoveredEntity;
private _weapon = [
    primaryWeapon _hoveredEntity,
    handgunWeapon _hoveredEntity,
    binocular _hoveredEntity
] select _args;
diag_log "_weapon";
diag_log _weapon;

private _cfgWeapon = configFile >> "CfgWeapons" >> _weapon;
private _displayName = getText (_cfgWeapon >> "displayName");
diag_log "_displayName";
diag_log _displayName;
if (_displayName != "") then {
    _action set [1, _displayName];
};
private _picture = getText (_cfgWeapon >> "picture");
diag_log "_picture";
diag_log _picture;
if (_picture != "") then {
    _action set [2, _picture];
};
