/*
 * Author: mharis001
 *
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_context_fnc_close
 *
 * Public: No
 */
#include "script_component.hpp"

{
    ctrlDelete _x;
} forEach GVAR(contextGroups);

GVAR(contextGroups) = [];
