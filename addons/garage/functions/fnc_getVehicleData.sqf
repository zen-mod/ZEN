#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns animation and texture data for given vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Vehicle data <ARRAY>
 *
 * Example:
 * [car] call zen_garage_fnc_getVehicleData
 *
 * Public: No
 */

params ["_vehicle"];

if (isNil QGVAR(vehicleDataCache)) then {
    GVAR(vehicleDataCache) = [] call CBA_fnc_createNamespace;
};

private _vehicleType = typeOf _vehicle;
private _vehicleData = GVAR(vehicleDataCache) getVariable _vehicleType;

if (isNil "_vehicleData") then {
    _vehicleData = [];

    private _vehicleConfig = configFile >> "CfgVehicles" >> _vehicleType;
    private _vehicleFaction = faction _vehicle;

    {
        private _entries = [];

        {
            private _displayName = getText (_x >> "displayName");
            private _factions = getArray (_x >> "factions");

            if (
                _displayName != ""
                && {getNumber (_x >> "scope") == 2 || {!isNumber (_x >> "scope")}}
                && {_factions isEqualTo [] || {_factions findIf {_x == _vehicleFaction} > -1}}
            ) then {
                _entries pushBack [configName _x, _displayName];
            };
        } forEach configProperties [_x, "isClass _x", true];

        _vehicleData pushBack _entries;
    } forEach [_vehicleConfig >> "animationSources", _vehicleConfig >> "textureSources"];

    GVAR(vehicleDataCache) setVariable [_vehicleType, _vehicleData];
};

+_vehicleData
