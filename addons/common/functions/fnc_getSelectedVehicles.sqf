#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns all currently selected vehicles by Zeus.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Vehicles <ARRAY>
 *
 * Example:
 * [] call zen_common_fnc_getSelectedVehicles
 *
 * Public: No
 */

SELECTED_OBJECTS select {_x isKindOf "LandVehicle" || {_x isKindOf "Air"} || {_x isKindOf "Ship"}}
