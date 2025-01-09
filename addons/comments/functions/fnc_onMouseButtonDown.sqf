#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles the mouse button down event for start moving a comment.
 *
 * Arguments:
 * 0: Icon control <CONTROL>
 * 1: Button pressed <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * _this call zen_comments_fnc_onMouseButtonDown
 *
 * Public: No
 */

params ["_ctrlIcon", "_button"];

if (_button != 0) exitWith {};

private _id = _ctrlIcon getVariable [QGVAR(comment), ""];
if (_id isEqualTo "") exitWith {ERROR("Moving invalid comment.")};

if (_id call FUNC(is3DENComment)) exitWith {};

(GVAR(comments) get _id) params ["_position"];
GVAR(movingComment) = [_id, +_position];
