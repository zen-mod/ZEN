#include "script_component.hpp"
/*
 * Author: Kex
 * Defines custom texture variant for all vehicles that inherit from the given vehicle type.
 *
 * Arguments:
 * 0: Base vehicle type <STRING>
 * 1: Texture variant name <STRING>
 * 2: Path of texture for each hidden selection <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicleType, variantName, [texturePath1, texturePath2]] call zen_garage_fnc_defineCustomTexture
 *
 * Public: Yes
 */

params ["_baseVehicleType", "_variantName", "_texture"];

if (isNil QGVAR(customVehicleTextures)) then {
    GVAR(customVehicleTextures) = [] call CBA_fnc_createNamespace;
};

{
    private _vehicleType = configName _x;
    // Clear garage cache
    GVAR(vehicleDataCache) setVariable [_vehicleType, nil];

    if (isNil {GVAR(customVehicleTextures) getVariable _vehicleType}) then {
        GVAR(customVehicleTextures) setVariable [_vehicleType, []];
    };
    private _textures = GVAR(customVehicleTextures) getVariable _vehicleType;
    _textures pushBack [_texture, _variantName];
} forEach (format ["configName _x isKindOf '%1'", _baseVehicleType] configClasses (configFile >> "CfgVehicles"));

nil
