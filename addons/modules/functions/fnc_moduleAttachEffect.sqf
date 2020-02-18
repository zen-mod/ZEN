#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to attach an effect to infantry units.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleAttachEffect
 *
 * Public: No
 */

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

private _fnc_attachEffect = {
    params ["_units", "_effectType"];

    {
        private _effect = _x getVariable [QGVAR(effect), objNull];

        if (!isNull _effect) then {
            detach _effect;

            // Hack for deleting IR Strobe effect
            _effect setPos [0, 0, -1000];
            [{deleteVehicle _this}, _effect, 2] call CBA_fnc_waitAndExecute;
        };
    } forEach _units;

    if (_effectType == "") exitWith {};

    {
        private _effect = createVehicle [_effectType, [0, 0, 0], [], 0, "CAN_COLLIDE"];
        _effect attachTo [_x, [0.05, -0.09, 0.1], "LeftShoulder"];
        _x setVariable [QGVAR(effect), _effect, true];
    } forEach _units;
};

private _effectsCache = uiNamespace getVariable QGVAR(effectsCache);
_effectsCache params ["_effectTypes", "_effectNames"];

if (isNull _unit) then {
    [LSTRING(AttachEffect), [
        [
            "SIDES",
            ELSTRING(common,Target),
            west
        ],
        [
            "COMBO",
            ELSTRING(common,Effect),
            [_effectTypes, _effectNames, 0]
        ]
    ], {
        params ["_values", "_fnc_attachEffect"];
        _values params ["_side", "_effectType"];

        private _units = allUnits select {side group _x == _side};
        [_units, _effectType] call _fnc_attachEffect;
    }, {}, _fnc_attachEffect] call EFUNC(dialog,create);
} else {
    if !(_unit isKindOf "CAManBase") exitWith {
        [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
    };

    if !(alive _unit) exitWith {
        [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
    };

    [LSTRING(AttachEffect), [
        [
            "TOOLBOX",
            ELSTRING(common,Target),
            [0, 1, 2, [ELSTRING(common,SelectedUnit), ELSTRING(common,SelectedGroup)]]
        ],
        [
            "COMBO",
            ELSTRING(common,Effect),
            [_effectTypes, _effectNames, 0]
        ]
    ], {
        params ["_values", "_args"];
        _values params ["_target", "_effectType"];
        _args params ["_unit", "_fnc_attachEffect"];

        private _units = if (_target == 1) then {units _unit} else {[_unit]};
        [_units, _effectType] call _fnc_attachEffect;
    }, {}, [_unit, _fnc_attachEffect]] call EFUNC(dialog,create);
};
