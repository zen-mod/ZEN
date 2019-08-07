#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles remote controlling a unit by ctrl double clicking.
 *
 * Arguments:
 * 0: Control (not used) <CONTROL>
 * 1: Button <NUMBER>
 * 2: X Pos (not used) <NUMBER>
 * 3: Y Pos (not used) <NUMBER>
 * 4: Shift State (not used) <BOOL>
 * 5: Ctrl State <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, 0, 0, false, true] call zen_remote_control_fnc_handleMouseDblClick
 *
 * Public: No
 */

params ["", "_button", "", "", "", "_ctrl"];

curatorMouseOver params ["_type", "_entity"];

if (_button == 0 && {_ctrl} && {_type == "OBJECT"} && {_entity call FUNC(canControl)}) exitWith {
    [_entity] call FUNC(start);
};
