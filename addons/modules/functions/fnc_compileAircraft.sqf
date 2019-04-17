/*
 * Author: mharis001
 * Compiles a list of all aircraft sorted by side and faction.
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
#include "script_component.hpp"

// Base array: east, west, independent, civilian
private _aircraftCache = [[], [], [], []];

// Compile all aircraft sorted based on side and faction
{
    private _vehicle = configName _x;

    if (getNumber (_x >> "scope") == 2 && {_vehicle isKindOf "Air"}) then {
        private _side = getNumber (_x >> "side");
        private _sideArray = _aircraftCache select _side;

        private _faction = getText (_x >> "faction");
        private _index   = _sideArray findIf {_x select 0 == _faction};

        if (_index == -1) then {
            _sideArray pushBack [_faction, [_vehicle]];
        } else {
            (_sideArray select _index select 1) pushBack _vehicle;
        };
    };
} forEach configProperties [configFile >> "CfgVehicles", "isClass _x"];

// Switch position of first two elements to make array easier to work with
// Final array: west, east, resistance, civilian
private _temp = +(_aircraftCache select 0);
_aircraftCache set [0, +(_aircraftCache select 1)];
_aircraftCache set [1, _temp];

uiNamespace setVariable [QGVAR(aircraftCache), _aircraftCache];
