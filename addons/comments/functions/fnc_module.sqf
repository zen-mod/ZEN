#include "script_component.hpp"
/*
 * Author: Timi007
 * Zeus module function to create a comment.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_comments_fnc_module
 *
 * Public: No
 */

params ["_logic"];

private _posASL = getPosASLVisual _logic;
deleteVehicle _logic;
[_posASL] call FUNC(createCommentDialog);
