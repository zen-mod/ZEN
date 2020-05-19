#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if a unit from the currently selected objects can be remote controlled.
 *
 * Arguments:
 * 0: Curator <OBJECT>
 *
 * Return Value:
 * Can Remote Control <BOOL>
 *
 * Example:
 * [_curator] call zen_compat_ace_fnc_remoteControl
 *
 * Public: No
 */

params ["_curator"];

SELECTED_OBJECTS findIf {_x call EFUNC(remote_control,canControl)} != -1
&& {[_curator, {"ace_interaction" in curatorAddons _this}, missionNamespace, QACEGVAR(interaction,zeusCheck), 1e9, "ace_interactMenuClosed"] call ACEFUNC(common,cachedCall)}
