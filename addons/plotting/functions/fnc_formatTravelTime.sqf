#include "script_component.hpp"
/*
 * Authors: Timi007
 * Formats the travel time to an appropriate format given by distance and speed.
 *
 * Arguments:
 * 0: Distance traveled in meters <NUMBER>
 * 1: Speed in meters per second <NUMBER>
 *
 * Return Value:
 * Formatted travel time in format H:MM:SS or M:SS <STRING>
 *
 * Example:
 * [100, 3.3] call zen_plotting_fnc_formatTravelTime
 *
 * Public: No
 */

params ["_distance", "_speed"];

private _time = _distance / _speed;

private _hours = floor (_time / 3600);
private _seconds = _time - (_hours * 3600);
private _minutes = floor (_seconds / 60);
_seconds = _seconds - (_minutes * 60);

// return
if (_hours > 0) then {
    format ["%1:%2:%3", _hours, [_minutes, 2] call CBA_fnc_formatNumber, [floor _seconds, 2] call CBA_fnc_formatNumber]
} else {
    format ["%1:%2", _minutes, [floor _seconds, 2] call CBA_fnc_formatNumber]
}
