#include "script_component.hpp"
/*
 * Authors: Timi007
 * Formats the given distance and speed.
 *
 * Arguments:
 * 0: Distance traveled in meters <NUMBER>
 * 1: Absolute speed in meters per second <NUMBER>
 *
 * Return Value:
 * Formatted travel time <STRING>
 *
 * Example:
 * [100, 3.3] call zen_plotting_fnc_formatTravelTime
 *
 * Public: No
 */

params [["_distance", 0, [0]], ["_speed", 0, [0]]];

private _kmh = round (abs _speed * 3.6);

// return
if (_kmh > 0) then {
    format ["%1 @ %2 km/h", [_distance, _speed] call FUNC(formatTravelTime), _kmh toFixed 0]
} else {
    "∞ @ 0 km/h"
}
