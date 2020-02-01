#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create a custom fire effect.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_moduleEffectFire
 *
 * Public: No
 */

params ["_display"];

private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
_display closeDisplay IDC_CANCEL; // Close helper display

// Need to delay dialog creation by one frame to avoid weird input blocking bug
[{
    params ["_logic"];

    private _params = _logic getVariable [QGVAR(fireParams), [[0.5, 0.5, 0.5], 1, 1, 25, 0.6, 1, 1, 0]];
    _params params ["_color", "_damage", "_size", "_density", "_lifetime", "_speed", "_particleSize", "_orientation"];

    [LSTRING(CustomFire), [
        [
            "COLOR",
            "str_3den_marker_attribute_color_displayname",
            +_color,
            true
        ],
        [
            "EDIT",
            ["STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_FireDamage_0", "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_FireDamage_1"],
            _damage,
            true
        ],
        [
            "EDIT",
            LSTRING(CustomFire_EffectSize),
            _size,
            true
        ],
        [
            "EDIT",
            [LSTRING(CustomFire_ParticleDensity), "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_ParticleDensity_1"],
            _density,
            true
        ],
        [
            "EDIT",
            [LSTRING(CustomFire_ParticleLifetime), "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_ParticleLifeTime_1"],
            _lifetime,
            true
        ],
        [
            "EDIT",
            LSTRING(CustomFire_ParticleSpeed),
            _speed,
            true
        ],
        [
            "EDIT",
            LSTRING(CustomFire_ParticleSize),
            _particleSize,
            true
        ],
        [
            "EDIT",
            LSTRING(CustomFire_ParticleOrientation),
            _orientation,
            true
        ]
    ], {
        params ["_values", "_logic"];
        _values params ["_color", "_damage", "_size", "_density", "_lifetime", "_speed", "_particleSize", "_orientation"];

        _damage       = parseNumber _damage;
        _size         = parseNumber _size;
        _density      = parseNumber _density;
        _lifetime     = parseNumber _lifetime;
        _speed        = parseNumber _speed;
        _particleSize = parseNumber _particleSize;
        _orientation  = parseNumber _orientation;

        _logic setVariable [QGVAR(fireParams), [_color, _damage, _size, _density, _lifetime, _speed, _particleSize, _orientation], true];

        private _jipID = _logic call BIS_fnc_netId;
        [QGVAR(moduleEffectFire), [_logic, _color, _damage, _size, _density, _lifetime, _speed, _particleSize, _orientation], _jipID] call CBA_fnc_globalEventJIP;
        [_jipID, _logic] call CBA_fnc_removeGlobalEventJIP;
    }, {
        params ["", "_logic"];

        // Delete logic if it does not have an attached fire effect
        if (isNil {_logic getVariable QGVAR(fireEffects)}) then {
            deleteVehicle _logic;
        };
    }, _logic] call EFUNC(dialog,create);
}, _logic] call CBA_fnc_execNextFrame;
