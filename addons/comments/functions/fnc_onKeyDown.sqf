#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles the key down event for a comment.
 *
 * Arguments:
 * 0: Icon control <CONTROL>
 * 1: Key pressed <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * _this call zen_comments_fnc_onKeyDown
 *
 * Public: No
 */

params ["_ctrlIcon", "_key"];
TRACE_1("params",_this);

if (_key != DIK_DELETE) exitWith {};

private _id = _ctrlIcon getVariable [QGVAR(comment), ""];
if (_id isEqualTo "") exitWith {};

if (!GVAR(allowDeleting3DEN) && {_id call FUNC(is3DENComment)}) exitWith {};

[QGVAR(deleteComment), [_id]] call CBA_fnc_serverEvent;
