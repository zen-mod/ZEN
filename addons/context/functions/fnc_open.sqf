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
 * [false] call zen_context_fnc_open
 *
 * Public: No
 */
#include "script_component.hpp"

// Close previously opened context menu
[] call FUNC(close);

// Update global variables for this context
GVAR(hovered) = curatorMouseOver;
GVAR(selected) = curatorSelected;

// Create base level context menu
[] call FUNC(create);
