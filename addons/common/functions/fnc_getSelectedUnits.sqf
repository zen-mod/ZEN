#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns all currently selected units by Zeus.
 * Includes crew of selected vehicles.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Units <ARRAY>
 *
 * Example:
 * [] call zen_common_fnc_getSelectedUnits
 *
 * Public: No
 */

private _units = [];

{
    _units append crew _x;
} forEach SELECTED_OBJECTS;

_units arrayIntersect _units
