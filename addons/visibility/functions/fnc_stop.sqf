#include "script_component.hpp"
/*
 * Author: Brett
 * Removes the Draw3D event handler.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_visibility_fnc_stop
 *
 * Public: No
 */

if (GVAR(draw) != -1) then {
    removeMissionEventHandler ["Draw3D", GVAR(draw)];
    GVAR(draw) = -1;
};
