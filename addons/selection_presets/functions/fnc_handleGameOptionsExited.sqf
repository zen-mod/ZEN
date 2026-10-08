#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles exiting the game options screen.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_selection_presets_fnc_handleGameOptionsExited
 *
 * Public: No
 */

[nil, true] call FUNC(queueRender);
