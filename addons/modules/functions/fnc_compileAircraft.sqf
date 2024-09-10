#include "script_component.hpp"
/*
 * Author: mharis001
 * Compiles a cache of all aircraft sorted by side and faction.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_modules_fnc_compileAircraft
 *
 * Public: No
 */

private _aircraftCache = [];

{
    private _className = configName _x;

    if (getNumber (_x >> "scope") == 2 && {_className isKindOf "Air"}) then {
        // Switch BLUFOR and OPFOR side IDs
        private _side = [1, 0, 2, 3] param [getNumber (_x >> "side"), 3];

        // Get the side's faction hash which maps factions to lists of aircraft
        private _factions = _aircraftCache param [_side];

        if (isNil "_factions") then {
            _factions = createHashMap;
            _aircraftCache set [_side, _factions];
        };

        // Add the aircraft type to the faction's aircraft list
        private _faction = getText (_x >> "faction");
        private _aircraft = _factions get _faction;

        if (isNil "_aircraft") then {
            _aircraft = [];
            _factions set [_faction, _aircraft];
        };

        _aircraft pushBack _className;
    };
} forEach configProperties [configFile >> "CfgVehicles", "isClass _x"];

uiNamespace setVariable [QGVAR(aircraftCache), _aircraftCache];
