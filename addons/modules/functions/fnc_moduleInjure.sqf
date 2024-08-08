#include "script_component.hpp"
/*
 * Author: CreepPork
 * Zeus module function to injure a player or an AI.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleInjure
 *
 * Public: No
 */

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

if !(_unit isKindOf "CAManBase") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if (!alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

private _fnc_getDamageDefault = {
    params ["_unit", "_hitpoint"];

    private _damage = _unit getHit _hitpoint;

    // Ranges are used if a unit gets shot and it's not the precise value anymore
    if (_damage == 0) exitWith { 0 }; // No damage
    if (_damage > 0 && _damage < 0.5) exitWith { 1 }; // Low damage
    if (_damage >= 0.5 && _damage < 0.9) exitWith { 2 }; // Medium (limping) damage
    if (_damage >= 0.9) exitWith { 3 }; // Severe damage
};

[
    LSTRING(ModuleInjure),
    [
        [
            "TOOLBOX",
            ELSTRING(damage,HitHead),
            [
                [_unit, "head"] call _fnc_getDamageDefault,
                1,
                4,
                ["None", "Low", "Medium", "Severe"]
            ],
            true
        ],
        [
            "TOOLBOX",
            ELSTRING(damage,HitBody),
            [
                [_unit, "body"] call _fnc_getDamageDefault,
                1,
                4,
                ["None", "Low", "Medium", "Severe"]
            ],
            true
        ],
        [
            "TOOLBOX",
            ELSTRING(damage,HitHands),
            [
                [_unit, "hands"] call _fnc_getDamageDefault,
                1,
                4,
                ["None", "Low", "Medium", "Severe"]
            ],
            true
        ],
        [
            "TOOLBOX",
            ELSTRING(damage,HitLegs),
            [
                [_unit, "legs"] call _fnc_getDamageDefault,
                1,
                4,
                ["None", "Low", "Limping", "Severe"]
            ],
            true
        ]
    ],
    {
        params ["_dialogValues", "_unit"];
        _dialogValues params ["_head", "_body", "_hands", "_legs"];
        private _damageValues = [0, 0.49, 0.7, 0.9];

        [QGVAR(injureUnit), [
            _unit,
            [
                ["head", _damageValues select _head],
                ["body", _damageValues select _body],
                ["hands", _damageValues select _hands],
                ["legs", _damageValues select _legs]
            ]
        ], _unit] call CBA_fnc_targetEvent;
    },
    {},
    _unit
] call EFUNC(dialog,create);
