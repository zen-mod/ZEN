#include "script_component.hpp"
/*
 * Author: mharis001
 * Teleports Zeus to the given position.
 *
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0]] call zen_context_actions_fnc_teleportZeus
 *
 * Public: No
 */

params ["_posASL"];

player setPosASL _posASL;
