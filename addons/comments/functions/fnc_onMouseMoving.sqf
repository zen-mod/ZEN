#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles the mouse moving event for moving a comment.
 *
 * Arguments:
 * 0: Icon control <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * _this call zen_comments_fnc_onMouseMoving
 *
 * Public: No
 */

params ["_ctrlIcon"];

if (GVAR(movingComment) isEqualTo []) exitWith {};

private _id = _ctrlIcon getVariable [QGVAR(comment), ""];
if (_id isEqualTo "") exitWith {ERROR("Moving invalid comment.")};

private _position = [] call EFUNC(common,getPosFromScreen);
[_id, _position, true] call FUNC(moveComment);
