#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create a persistent smoke pillar.
 * Smoke templates are from: https://community.bistudio.com/wiki/ParticleTemplates.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleSmokePillar
 *
 * Public: No
 */

params ["_logic"];

[LSTRING(ModuleSmokePillar), [
    ["COMBO", LSTRING(SmokePillarType), [[], [
        LSTRING(VehicleFire),
        LSTRING(SmallOilySmoke),
        LSTRING(MediumOilySmoke),
        LSTRING(LargeOilySmoke),
        LSTRING(SmallWoodSmoke),
        LSTRING(MediumWoodSmoke),
        LSTRING(LargeWoodSmoke),
        LSTRING(SmallMixedSmoke),
        LSTRING(MediumMixedSmoke),
        LSTRING(LargeMixedSmoke)
    ], 0]]
], {
    params ["_dialogValues", "_logic"];
    _dialogValues params ["_smokeType"];

    private _jipID = switch (_smokeType) do {
        case 0: { // Vehicle Fire
            private _particleSource1 = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            private _particleSource2 = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            private _particleSource3 = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            _logic setVariable [QGVAR(particleSources), [_particleSource1, _particleSource2, _particleSource3]];

            [QEGVAR(common,execute), [{
                params ["_logic", "_particleSource1", "_particleSource2", "_particleSource3"];

                _particleSource1 setParticleCircle [0, [0, 0, 0]];
                _particleSource1 setParticleRandom [0.2, [1, 1, 0], [0.5, 0.5, 0], 1, 0.5, [0, 0, 0, 0], 0, 0];
                _particleSource1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 2, 6], "", "Billboard", 1, 1, [0, 0, 0], [0, 0, 0.5], 1, 1, 0.9, 0.3, [1.5], [[1, 0.7, 0.7, 0.5]], [1], 0, 0, "", "", _logic];
                _particleSource1 setDropInterval 0.03;

                _particleSource2 setParticleCircle [0, [0, 0, 0]];
                _particleSource2 setParticleRandom [0, [0, 0, 0], [0.33, 0.33, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0];
                _particleSource2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 0, 1], "", "Billboard", 1, 10, [0, 0, 0.5], [0, 0, 2.9], 1, 1.275, 1, 0.066, [4, 5, 10, 10], [[0.3, 0.3, 0.3, 0.33], [0.4, 0.4, 0.4, 0.33], [0.2, 0.2, 0, 0]], [0, 1], 1, 0, "", "", _logic];
                _particleSource2 setDropInterval 0.5;

                _particleSource3 setParticleCircle [0, [0, 0, 0]];
                _particleSource3 setParticleRandom [0, [0, 0, 0], [0.5, 0.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0];
                _particleSource3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 15, [0, 0, 0.5], [0, 0, 2.9], 1, 1.275, 1, 0.066, [4, 5, 10, 10], [[0.1, 0.1, 0.1, 0.75], [0.4, 0.4, 0.4, 0.5], [1, 1, 1, 0.2]], [0], 1, 0, "", "", _logic];
                _particleSource3 setDropInterval 0.25;
            }, [_logic, _particleSource1, _particleSource2, _particleSource3]]] call CBA_fnc_globalEventJIP;
        };
        case 1: { // Small Oily Smoke
            private _particleSource = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            _logic setVariable [QGVAR(particleSources), [_particleSource]];

            [QEGVAR(common,execute), [{
                params ["_logic", "_particleSource"];

                _particleSource setParticleCircle [0, [0, 0, 0]];
                _particleSource setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 8], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 1.5], 0, 10, 7.9, 0.066, [1, 3, 6], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource setDropInterval 0.05;
            }, [_logic, _particleSource]]] call CBA_fnc_globalEventJIP;
        };
        case 2: { // Medium Oily Smoke
            private _particleSource = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            _logic setVariable [QGVAR(particleSources), [_particleSource]];

            [QEGVAR(common,execute), [{
                params ["_logic", "_particleSource"];

                _particleSource setParticleCircle [0, [0, 0, 0]];
                _particleSource setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 8], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 2.5], 0, 10, 7.9, 0.066, [2, 6, 12], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource setDropInterval 0.1;
            }, [_logic, _particleSource]]] call CBA_fnc_globalEventJIP;
        };
        case 3: { // Large Oily Smoke
            private _particleSource = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            _logic setVariable [QGVAR(particleSources), [_particleSource]];

            [QEGVAR(common,execute), [{
                params ["_logic", "_particleSource"];

                _particleSource setParticleCircle [0, [0, 0, 0]];
                _particleSource setParticleRandom [0, [0.5, 0.5, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 6], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 4.5], 0, 10, 7.9, 0.5, [4, 12, 20], [[0.1, 0.1, 0.1, 0.8], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource setDropInterval 0.1;
            }, [_logic, _particleSource]]] call CBA_fnc_globalEventJIP;
        };
        case 4: { // Small Wood Smoke
            private _particleSource = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            _logic setVariable [QGVAR(particleSources), [_particleSource]];

            [QEGVAR(common,execute), [{
                params ["_logic", "_particleSource"];

                _particleSource setParticleCircle [0, [0, 0, 0]];
                _particleSource setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 1.5], 0, 10, 7.9, 0.066, [1, 3, 6], [[0.5, 0.5, 0.5, 0.15], [0.75, 0.75, 0.75, 0.075], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource setDropInterval 0.05;
            }, [_logic, _particleSource]]] call CBA_fnc_globalEventJIP;
        };
        case 5: { // Medium Wood Smoke
            private _particleSource = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            _logic setVariable [QGVAR(particleSources), [_particleSource]];

            [QEGVAR(common,execute), [{
                params ["_logic", "_particleSource"];

                _particleSource setParticleCircle [0, [0, 0, 0]];
                _particleSource setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 2.5], 0, 10, 7.9, 0.066, [2, 6, 12], [[0.5, 0.5, 0.5, 0.3], [0.75, 0.75, 0.75, 0.15], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource setDropInterval 0.1;
            }, [_logic, _particleSource]]] call CBA_fnc_globalEventJIP;
        };
        case 6: { // Large Wood Smoke
            private _particleSource = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            _logic setVariable [QGVAR(particleSources), [_particleSource]];

            [QEGVAR(common,execute), [{
                params ["_logic", "_particleSource"];

                _particleSource setParticleCircle [0, [0, 0, 0]];
                _particleSource setParticleRandom [0, [0.5, 0.5, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 4.5], 0, 10, 7.9, 0.5, [4, 12, 20], [[0.5, 0.5, 0.5, 0.5], [0.75, 0.75, 0.75, 0.25], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource setDropInterval 0.1;
            }, [_logic, _particleSource]]] call CBA_fnc_globalEventJIP;
        };
        case 7: { // Small Mixed Smoke
            private _particleSource1 = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            private _particleSource2 = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            _logic setVariable [QGVAR(particleSources), [_particleSource1, _particleSource2]];

            [QEGVAR(common,execute), [{
                params ["_logic", "_particleSource1", "_particleSource2"];

                _particleSource1 setParticleCircle [0, [0, 0, 0]];
                _particleSource1 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 8], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 1.5], 0, 10, 7.9, 0.066, [1, 3, 6], [[0.2, 0.2, 0.2, 0.45], [0.35, 0.35, 0.35, 0.225], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource1 setDropInterval 0.1;

                _particleSource2 setParticleCircle [0, [0, 0, 0]];
                _particleSource2 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 1.5], 0, 10, 7.9, 0.066, [1, 3, 6], [[0.33, 0.33, 0.33, 0.8], [0.66, 0.66, 0.66, 0.4], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource2 setDropInterval 0.1;
            }, [_logic, _particleSource1, _particleSource2]]] call CBA_fnc_globalEventJIP;
        };
        case 8: { // Medium Mixed Smoke
            private _particleSource1 = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            private _particleSource2 = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            _logic setVariable [QGVAR(particleSources), [_particleSource1, _particleSource2]];

            [QEGVAR(common,execute), [{
                params ["_logic", "_particleSource1", "_particleSource2"];

                _particleSource1 setParticleCircle [0, [0, 0, 0]];
                _particleSource1 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 8], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 2.5], 0, 10, 7.9, 0.066, [2, 6, 12], [[0.2, 0.2, 0.2, 0.3], [0.35, 0.35, 0.35, 0.2], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource1 setDropInterval 0.2;

                _particleSource2 setParticleCircle [0, [0, 0, 0]];
                _particleSource2 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 2.5], 0, 10, 7.9, 0.066, [2, 6, 12], [[0.33, 0.33, 0.33, 0.8], [0.66, 0.66, 0.66, 0.4], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource2 setDropInterval 0.2;
            }, [_logic, _particleSource1, _particleSource2]]] call CBA_fnc_globalEventJIP;
        };
        case 9: { // Large Mixed Smoke
            private _particleSource1 = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            private _particleSource2 = createVehicle ["#particlesource", _logic, [], 0, "NONE"];
            _logic setVariable [QGVAR(particleSources), [_particleSource1, _particleSource2]];

            [QEGVAR(common,execute), [{
                params ["_logic", "_particleSource1", "_particleSource2"];

                _particleSource1 setParticleCircle [0, [0, 0, 0]];
                _particleSource1 setParticleRandom [0, [0.4, 0.4, 0], [0.4, 0.4, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 6], "", "billboard", 1, 8, [0, 0, 0], [0, 0, 4.5], 0, 10, 7.9, 0.5, [4, 12, 20], [[0.2, 0.2, 0.2, 0.3], [0.35, 0.35, 0.35, 0.2], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource1 setDropInterval 0.2;

                _particleSource2 setParticleCircle [0, [0, 0, 0]];
                _particleSource2 setParticleRandom [0, [0.4, 0.4, 0], [0.4, 0.4, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
                _particleSource2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "billboard", 1, 8, [0, 0, 0], [0, 0, 4.5], 0, 10, 7.9, 0.5, [4, 12, 20], [[0.33, 0.33, 0.33, 0.8], [0.66, 0.66, 0.66, 0.4], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _logic];
                _particleSource2 setDropInterval 0.2;
            }, [_logic, _particleSource1, _particleSource2]]] call CBA_fnc_globalEventJIP;
        };
    };

    _logic addEventHandler ["Deleted", {
        params ["_logic"];

        private _particleSources = _logic getVariable [QGVAR(particleSources), []];
        {deleteVehicle _x} forEach _particleSources;
    }];

    [_jipID, _logic] call CBA_fnc_removeGlobalEventJIP;
}, {
    params ["", "_logic"];

    deleteVehicle _logic;
}, _logic] call EFUNC(dialog,create);
