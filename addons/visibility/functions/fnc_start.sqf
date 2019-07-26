#include "script_component.hpp"
/*
 * Author: Brett
 * Starts the Draw3D EH that indicates when a player can see the curator cursor.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_visibility_fnc_start
 *
 * Public: No
 */

if (GVAR(draw) != -1) exitWith {};

GVAR(draw) = addMissionEventHandler ["Draw3D", {call FUNC(draw)}];
