#include "script_component.hpp"
/*
 * Author: Fusselwurm
 * Set the alpha of a marker depending on the player's side.
 *
 * Arguments:
 * 0: Marker <STRING>
 * 1: Sides that may see the marker <ARRAY>
 * 2: Alpha value to use for players of passed `sides`
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0", [west,civilian], 0.7] call zen_area_markers_fnc_updateAlpha
 *
 * Public: No
 */

params ["_marker", "_sides", "_alpha"];

if (isServer) exitWith {
    [GVAR(markerVisibilities), _marker, _sides] call CBA_fnc_hashSet;
    publicVariable QGVAR(markerVisibilities);
};

if (!hasInterface) exitWith {}; // ignore HCs

private _localAlpha = if (
    (playerSide in _sides) ||
    (!isNull (getAssignedCuratorLogic player)) // ZEUS should always see the markers!
) then { _alpha } else { 0 };

_marker setMarkerAlphaLocal _localAlpha;
