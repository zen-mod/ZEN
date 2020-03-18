#include "script_component.hpp"
/*
 * Author: Bohemia Interactive, Moerderhoschi, mharis001
 * Zeus module function to detonate a nuclear bomb.
 *
 * Arguments:
 * 0: Position ASL <ARRAY>
 * 1: Destruction Radius <NUMBER>
 * 2: Color Corrections <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_position, 1000, true] call zen_modules_fnc_moduleNukeLocal
 *
 * Public: No
 */

params ["_position", "_destructionRadius", "_colorCorrections"];

// Destruction effects, only handled on the server
if (isServer) then {
    {
        if (isDamageAllowed _x && {!(_x isKindOf "Logic")} && {!(_x isKindOf "VirtualMan_F")}) then {
            private _delay = linearConversion [0, _destructionRadius, _x distance2D _position, 0, 20, true];
            [{_this setDamage 1}, _x, _delay] call CBA_fnc_waitAndExecute;
        };
    } forEach nearestObjects [ASLtoAGL _position, [], _destructionRadius];
};

// Exit if local visual effects are not needed
if (!hasInterface) exitWith {};

private _source = "Logic" createVehicleLocal [0, 0, 0];
_source setPosASL _position;

private _cone = "#particlesource" createVehicleLocal [0, 0, 0];
_cone setPosASL _position;

_cone setParticleParams [
    ["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48],
    "",
    "Billboard",
    1,
    10,
    [0, 0, 0],
    [0, 0, 0],
    0,
    1.275,
    1,
    0,
    [40, 80],
    [
        [0.25, 0.25, 0.25, 0],
        [0.25, 0.25, 0.25, 0.5],
        [0.25, 0.25, 0.25, 0.5],
        [0.25, 0.25, 0.25, 0.05],
        [0.25, 0.25, 0.25, 0]
    ],
    [0.25],
    0.1,
    1,
    "",
    "",
    _source
];

_cone setParticleRandom [2, [1, 1, 30], [1, 1, 30], 0, 0, [0, 0, 0, 0.1], 0, 0];
_cone setParticleCircle [10, [-10, -10, 20]];
_cone setDropInterval 0.005;

private _top1 = "#particlesource" createVehicleLocal [0, 0, 0];
_top1 setPosASL _position;

_top1 setParticleParams [
    ["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 48, 0],
    "",
    "Billboard",
    1,
    20,
    [0, 0, 0],
    [0, 0, 60],
    0,
    1.7,
    1,
    0,
    [60, 80, 100],
    [
        [1, 1, 1, -10],
        [1, 1, 1, -7],
        [1, 1, 1, -4],
        [1, 1, 1, -0.5],
        [1, 1, 1, 0]
    ],
    [0.05],
    1,
    1,
    "",
    "",
    _source
];

_top1 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top1 setDropInterval 0.002;

private _top2 = "#particlesource" createVehicleLocal [0, 0, 0];
_top2 setPosASL _position;

_top2 setParticleParams [
    ["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 112, 0],
    "",
    "Billboard",
    1,
    20,
    [0, 0, 0],
    [0, 0, 60],
    0,
    1.7,
    1,
    0,
    [60, 80, 100],
    [
        [1, 1, 1, 0.5],
        [1, 1, 1, 0]
    ],
    [0.07],
    1,
    1,
    "",
    "",
    _source
];

_top2 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top2 setDropInterval 0.002;

private _smoke = "#particlesource" createVehicleLocal [0, 0, 0];
_smoke setPosASL _position;

_smoke setParticleParams [
    ["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1],
    "",
    "Billboard",
    1,
    25,
    [0, 0, 0],
    [0, 0, 60],
    0,
    1.7,
    1,
    0,
    [40, 15, 120],
    [
        [1, 1, 1, 0.4],
        [1, 1, 1, 0.7],
        [1, 1, 1, 0.7],
        [1, 1, 1, 0.7],
        [1, 1, 1, 0.7],
        [1, 1, 1, 0.7],
        [1, 1, 1, 0.7],
        [1, 1, 1, 0]
    ],
    [0.5, 0.1],
    1,
    1,
    "",
    "",
    _source
];

_smoke setParticleRandom [0, [10, 10, 15], [15, 15, 7], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_smoke setDropInterval 0.002;

private _wave = "#particlesource" createVehicleLocal [0, 0, 0];
_wave setPosASL _position;

_wave setParticleParams [
    ["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48],
    "",
    "Billboard",
    1,
    20,
    [0, 0, 0],
    [0, 0, 0],
    0,
    1.5,
    1,
    0,
    [50, 100],
    [
        [0.1, 0.1, 0.1, 0.5],
        [0.5, 0.5, 0.5, 0.5],
        [1, 1, 1, 0.3],
        [1, 1, 1, 0]
    ],
    [1, 0.5],
    0.1,
    1,
    "",
    "",
    _source
];

_wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
_wave setParticleCircle [50, [-80, -80, 2.5]];
_wave setDropInterval 0.0002;

private _light = "#lightpoint" createVehicleLocal [0, 0, 0];
_light setPosASL (_position vectorAdd [0, 0, 500]);

_light setLightAmbient [1, 0.8, 0.67];
_light setLightColor [1, 0.8, 0.67];
_light setLightBrightness 100;

[{
    15 fadeMusic _this;
}, musicVolume, 2] call CBA_fnc_waitAndExecute;

0 fadeMusic 1;

[3] call EFUNC(common,earthquake);

[{
    enableCamShake true;
    addCamShake [5, 10, 25];
}, [], 2] call CBA_fnc_waitAndExecute;

if (_colorCorrections) then {
    "colorCorrections" ppEffectEnable true;
    "colorCorrections" ppEffectAdjust [2, 30, 0, [0, 0, 0, 0], [1.6, 1, 0, 0.7], [0.9, 0.9, 0.9, 0]];
    "colorCorrections" ppEffectCommit 0;

    "colorCorrections" ppEffectAdjust [1, 0.8, -0.001, [0, 0, 0, 0], [1.6, 1, 0, 0.7], [0.9, 0.9, 0.9, 0]];
    "colorCorrections" ppEffectCommit 3;

    "filmGrain" ppEffectEnable true;
    "filmGrain" ppEffectAdjust [0.02, 1, 1, 0.1, 1, false];
    "filmGrain" ppEffectCommit 5;
};

[{
    _this setDropInterval 0.0005;
}, _wave, 2] call CBA_fnc_waitAndExecute;

[{
    _this setDropInterval 0.001;
}, _wave, 10] call CBA_fnc_waitAndExecute;

[{
    {deleteVehicle _x} forEach _this;
}, [_top1, _top2], 2] call CBA_fnc_waitAndExecute;

[{
    params ["_source", "_cone", "_smoke", "_wave", "_light"];

    [{
        params ["_light", "_endTime"];

        private _brightness = linearConversion [15, 0, _endTime - CBA_missionTime, 100, 0, true];
        _light setLightBrightness _brightness;

        CBA_missionTime >= _endTime
    }, {
        params ["_light"];

        deleteVehicle _light;
    }, [_light, CBA_missionTime + 15]] call CBA_fnc_waitUntilAndExecute;

    [{
        params ["_source", "_cone", "_smoke", "_wave"];

        _smoke setParticleParams [
            ["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1],
            "",
            "Billboard",
            1,
            25,
            [0, 0, 0],
            [0, 0, 45],
            0,
            1.7,
            1,
            0,
            [40, 25, 80],
            [
                [1, 1, 1, 0.2],
                [1, 1, 1, 0.3],
                [1, 1, 1, 0.3],
                [1, 1, 1, 0.3],
                [1, 1, 1, 0.3],
                [1, 1, 1, 0.3],
                [1, 1, 1, 0.3],
                [1, 1, 1, 0]
            ],
            [0.5, 0.1],
            1,
            1,
            "",
            "",
            _source
        ];

        _cone setDropInterval 0.01;
        _smoke setDropInterval 0.006;
        _wave setDropInterval 0.001;

        [{
            params ["_source", "_cone", "_smoke", "_wave"];

            _smoke setParticleParams [
                ["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1],
                "",
                "Billboard",
                1,
                25,
                [0, 0, 0],
                [0, 0, 30],
                0,
                1.7,
                1,
                0,
                [40, 25, 80],
                [
                    [1, 1, 1, 0.2],
                    [1, 1, 1, 0.3],
                    [1, 1, 1, 0.3],
                    [1, 1, 1, 0.3],
                    [1, 1, 1, 0.3],
                    [1, 1, 1, 0.3],
                    [1, 1, 1, 0.3],
                    [1, 1, 1, 0]
                ],
                [0.5, 0.1],
                1,
                1,
                "",
                "",
                _source
            ];

            _cone setDropInterval 0.02;
            _smoke setDropInterval 0.012;
            _wave setDropInterval 0.01;

            private _ash = "#particlesource" createVehicleLocal [0, 0, 0];
            _ash setPosASL getPosASL player;

            _ash setParticleParams [
                ["A3\Data_F\ParticleEffects\Universal\Universal", 16, 12, 8, 1],
                "",
                "Billboard",
                1,
                4,
                [0, 0, 0],
                [0, 0, 0],
                1,
                0.000001,
                0,
                1.4,
                [0.05, 0.05],
                [
                    [0.1, 0.1, 0.1, 1]
                ],
                [0, 1],
                0.2,
                1.2,
                "",
                "",
                player
            ];

            _ash setParticleRandom [0, [10, 10, 7], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
            _ash setParticleCircle [0, [0, 0, 0]];
            _ash setDropInterval 0.01;

            [{
                {deleteVehicle _x} forEach _this;
            }, _this, 20] call CBA_fnc_waitAndExecute;
        }, _this, 2] call CBA_fnc_waitAndExecute;
    }, [_source, _cone, _smoke, _wave], 12] call CBA_fnc_waitAndExecute;
}, [_source, _cone, _smoke, _wave, _light], 5] call CBA_fnc_waitAndExecute;
