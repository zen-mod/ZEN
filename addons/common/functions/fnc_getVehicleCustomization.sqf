#include "script_component.hpp"
/*
 * Author: Kex
 * Return vehicle customization settings.
 * Based on BIS_fnc_getVehicleCustomization.
 * In contrast to BIS_fnc_getVehicleCustomization, it works properly for doors
 * and textures are returned as an array of texture paths (i.e. output of getObjectTextures).
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Array of texture paths and array of animations <ARRAY>
 *
 * Example:
 * [vehicle player] call zen_common_fnc_getVehicleCustomization
 *
 * Public: No
 */

params ["_vehicle"];

private _vehicleType = typeOf _vehicle;
private _vehicleConfig = configFile >> "CfgVehicles" >> _vehicleType;

private _animations = [];
{
    private _config = _x;
    private _configName = toLower configName _config;
    private _source = toLower getText (_config >> "source");

    if (_source in WHITELIST_ANIMATION_SOURCES && {BLACKLIST_ANIMATION_INNAMES findIf {_x in _configName} == -1 && {BLACKLIST_ANIMATION_ATTRIBUTES findIf {isClass (_config >> _x)} == -1}}) then {
        private _phase = switch (_source) do {
            case "door": {
                _vehicle doorPhase _configName;
            };
            case "user": {
                _vehicle animationSourcePhase _configName;
            };
            default {
                _vehicle animationPhase _configName;
            };
        };
        // Some sources will return negative values
        if (_phase >= 0) then {
            _animations append [_configName, _phase];
        }
    };
} forEach configProperties [_vehicleConfig >> "animationSources", "isClass _x", true];

private _textures = getObjectTextures _vehicle;

[_textures, _animations]
