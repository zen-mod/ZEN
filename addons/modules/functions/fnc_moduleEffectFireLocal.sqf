#include "script_component.hpp"
/*
 * Author: Bohemia Interactive, mharis001
 * Zeus module function to create a custom fire effect.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Fire Color <ARRAY>
 * 2: Fire Damage <NUMBER>
 * 3: Effect Size <NUMBER>
 * 4: Particle Density <NUMBER>
 * 5: Particle Lifetime <NUMBER>
 * 6: Particle Speed <NUMBER>
 * 7: Particle Size <NUMBER>
 * 8: Particle Orientation <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic, [0.5, 0.5, 0.5], 1, 1, 25, 0.6, 1, 1, 0] call zen_modules_fnc_moduleEffectFireLocal
 *
 * Public: No
 */

params ["_logic", "_color", "_damage", "_size", "_density", "_lifetime", "_speed", "_particleSize", "_orientation"];
_color params ["_colorRed", "_colorGreen", "_colorBlue"];

if (isServer) then {
    // Add logic object to all curators for QOL
    [_logic] call EFUNC(common,updateEditableObjects);

    // Create global fire sound effect if not created yet
    private _sound = _logic getVariable QGVAR(fireSound);

    if (isNil "_sound") then {
        _sound = createSoundSource ["Sound_Fire", [0, 0, 0], [], 0];
        _sound attachTo [_logic, [0, 0, 0.25]];

        [_logic, "Deleted", {
            deleteVehicle _thisArgs;
        }, _sound] call CBA_fnc_addBISEventHandler;

        _logic setVariable [QGVAR(fireSound), _sound];
    };
};

// Exit if local visual effects are not needed
if (!hasInterface) exitWith {};

// Create local effect objects if not created yet
private _effects = _logic getVariable QGVAR(fireEffects);

if (isNil "_effects") then {
    _effects = [
        "#particlesource" createVehicleLocal [0, 0, 0],
        "#lightpoint"     createVehicleLocal [0, 0, 0]
    ];

    [_logic, "Deleted", {
        {deleteVehicle _x} forEach _thisArgs;
    }, _effects] call CBA_fnc_addBISEventHandler;

    _logic setVariable [QGVAR(fireEffects), _effects];
};

_effects params ["_source", "_light"];

// Create fire particle effect
_source setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 10, 32],
    "",
    "billboard",
    1,
    _lifetime,
    [0, 0, 0],
    [0, 0, 0.4 * _speed],
    0,
    0.0565,
    0.05,
    0.03,
    [0.9 * _particleSize, 0],
    [
        [_colorRed, _colorGreen, _colorBlue, 0],
        [_colorRed, _colorGreen, _colorBlue, -1],
        [_colorRed, _colorGreen, _colorBlue, -1],
        [_colorRed, _colorGreen, _colorBlue, -1],
        [_colorRed, _colorGreen, _colorBlue, -1],
        [_colorRed, _colorGreen, _colorBlue, 0]
    ],
    [1],
    0.01,
    0.02,
    "",
    "",
    "",
    _orientation,
    false,
    -1,
    [[3, 3, 3, 0]]
];

_source setParticleRandom [_lifetime / 4, [0.15 * _size, 0.15 * _size, 0], [0.2, 0.2, 0], 0.4, 0, [0, 0, 0, 0], 0, 0, 0.2];

if (_damage > 0) then {
    _source setParticleFire [0.6 * _damage, 0.25 * _damage, 0.1];
} else {
    _source setParticleFire [0, 0, 0];
};

_source setDropInterval (1 / _density);
_source attachTo [_logic, [0, 0, 0]];

// Create light source effect
_light setLightBrightness 1;
_light setLightColor [1, 0.65, 0.4];
_light setLightAmbient [0.15, 0.05, 0];
_light setLightIntensity (50 + 200 * (_size + _particleSize));
_light setLightAttenuation [0, 0, 0, 1];
_light setLightDayLight false;

_light lightAttachObject [_logic, [0, 0, 0.5]];
