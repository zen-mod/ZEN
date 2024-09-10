#include "script_component.hpp"
/*
 * Author: Bohemia Interactive, mharis001
 * Removes the cover map effect.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_cover_map_fnc_remove
 *
 * Public: No
 */

// Delete all markers created by the cover map effect
{
    if (QUOTE(ADDON) in _x) then {
        deleteMarker _x;
    };
} forEach allMapMarkers;
