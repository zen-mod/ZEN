#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles the mouse button double click event for a comment.
 *
 * Arguments:
 * 0: Icon control <CONTROL>
 * 1: Mouse button pressed <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * _this call zen_comments_fnc_onMouseDblClick
 *
 * Public: No
 */

params ["_ctrlIcon", "_button"];
TRACE_1("params",_this);

if (_button != 0) exitWith {};

private _id = _ctrlIcon getVariable [QGVAR(comment), ""];
if (_id isEqualTo "" || {_id call FUNC(is3DENComment)}) exitWith {};

TRACE_1("Edit comment",_id);

[_id] call FUNC(updateCommentDialog);
