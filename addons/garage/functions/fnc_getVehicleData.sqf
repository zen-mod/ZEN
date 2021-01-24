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
    private _vehicleConfig = configFile >> "CfgVehicles" >> _vehicleType;

    private _animations = [];
    ([_vehicle] call EFUNC(common,getVehicleCustomization)) params ["", "_currentAnimations"];
    for "_i" from 0 to (count _currentAnimations - 2) step 2 do {
        private _configName = _currentAnimations select _i;
        private _displayName = getText (_vehicleConfig >> "animationSources" >> _configName >> "displayName");
        if (_displayName isEqualTo "") then {
            _displayName = (_configName splitString "_") joinString " ";
        };
        _animations pushBack [_configName, _displayName];
    };

    private _textures = [];
    {
        private _configName = configName _x;
        private _displayName = getText (_x >> "displayName");
        if (_displayName isEqualTo "") then {
            _displayName = (_configName splitString "_") joinString " ";
        };
        _textures pushBack [_configName, _displayName];
    } forEach configProperties [_vehicleConfig >> "textureSources", "isClass _x", true];

    // Adding custom definitions
    private _customTextures = GVAR(customVehicleTextures) getVariable [_vehicleType, []];
    _textures append _customTextures;

    _vehicleData = [_animations, _textures];

    GVAR(vehicleDataCache) setVariable [_vehicleType, _vehicleData];
};

+_vehicleData
