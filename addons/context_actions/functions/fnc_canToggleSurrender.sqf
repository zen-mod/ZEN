#include "script_component.hpp"
/*
 * Author: Eclipser
 * Checks if the given objects list contains units whose surrendering state can be toggled.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * Can Toggle Surrender <BOOL>
 *
 * Example:
 * [_object] call zen_context_actions_fnc_canToggleSurrender
 *
 * Public: No
 */

_this findIf {alive _x && {_x isKindOf "CAManBase"} && {!(_x getVariable ["ace_captives_isHandcuffed", false])}} != -1
