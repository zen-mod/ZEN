#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles the mouse button down event for stop moving a comment.
 *
 * Arguments:
 * 0: Icon control <CONTROL>
 * 1: Button pressed <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * _this call zen_comments_fnc_onMouseButtonUp
 *
 * Public: No
 */

params ["_ctrlIcon", "_button"];

if (_button != 0 || GVAR(movingComment) isEqualTo []) exitWith {};

private _id = _ctrlIcon getVariable [QGVAR(comment), ""];
if (_id isEqualTo "") exitWith {ERROR("Moving invalid comment.")};

private _position = [] call EFUNC(common,getPosFromScreen);
[_id, _position] call FUNC(moveComment);

GVAR(movingComment) = [];
