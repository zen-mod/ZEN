#include "script_component.hpp"
/*
 * Author: Kex
 * Changes the textures, animation sources and/or mass of a given vehicle.
 * Based on BIS_fnc_initVehicle, but can be applied multiple times without issues.
 * In contrast to BIS_fnc_initVehicle, if texture is passed as an array,
 * it can also alternatively be an array of texture paths (i.e. output of getObjectTextures).
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Texture <BOOLEAN|ARRAY|STRING>
 * 2: Animation <BOOLEAN|ARRAY|STRING>
 * 3: Mass <BOOLEAN|NUMBER>
 * 4: Instant animation <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, [texturePath1, texturePath2], [animationSource1, animationPhase1]] call zen_common_fnc_customizeVehicle
 *
 * Public: No
 */

params ["_vehicle", ["_texture", false, [false, [], ""]], ["_animation", false, [false, [], ""]], ["_mass", false, [false, 0]], ["_instantAnimation", true, [false]]];

private _vehicleType = typeOf _vehicle;

// Fix: BIS_fnc_initVehicle cannot animate doors multiple times
if (_animation isEqualType []) then {
    for "_i" from 0 to (count _animation - 2) step 2 do {
        private _configName = _animation select _i;
        private _source = getText (configFile >> "CfgVehicles" >> _vehicleType >> "animationSources" >> _configName >> "source");
        private _phase = _animation select (_i + 1);
        switch (_source) do {
            case "door": {
                _vehicle animateDoor [_configName, _phase, _instantAnimation];
            };
            case "user": {
                _vehicle animateSource [_configName, _phase, _instantAnimation];
            };
            default {
                _vehicle animate [_configName, _phase, _instantAnimation];
            };
        };
    };
};

if (_texture isEqualType [] && {count _texture < 2 || {(_texture select 1) isEqualType ""}}) then {
    [_vehicle, nil, nil, _mass] call BIS_fnc_initVehicle;
    {
        _vehicle setObjectTextureGlobal [_forEachIndex, _x];
    } forEach _texture;
} else {
    [_vehicle, _texture, nil, _mass] call BIS_fnc_initVehicle;
};

nil
