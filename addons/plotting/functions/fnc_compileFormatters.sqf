#include "script_component.hpp"
/*
 * Authors: Timi007
 * Compiles formatters from config and saves them in missionNamespace.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_plotting_fnc_compileFormatters
 *
 * Public: No
 */

private _fnc_getFormatters = {
    params ["_cfgFormatters"];

    private _formatters = [];
    {
        private _entryConfig = _x;

        private _formatterName = configName _entryConfig;

        private _formatterString = getText (_entryConfig >> "formatter");
        if (_formatterString isNotEqualTo "") then {
            _formatterString = "params ['_value']; " + _formatterString;
        };
        private _formatter = compile _formatterString;

        private _priority = getNumber (_entryConfig >> "priority");

        private _formatterEntry = [
            _formatterName,
            _formatter,
            _priority
        ];

        _formatters pushBack _formatterEntry;
    } forEach configProperties [_cfgFormatters, "isClass _x", true];

    [_formatters, 3, false] call CBA_fnc_sortNestedArray
};

private _cfgFormatters = configFile >> QGVAR(formatters);
private _distanceFormatters = [_cfgFormatters >> "Distance"] call _fnc_getFormatters;
private _azimuthFormatters = [_cfgFormatters >> "Azimuth"] call _fnc_getFormatters;

missionNamespace setVariable [QGVAR(distanceFormatters), _distanceFormatters];
missionNamespace setVariable [QGVAR(azimuthFormatters), _azimuthFormatters];
