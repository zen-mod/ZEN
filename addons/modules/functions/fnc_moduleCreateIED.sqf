/*
 * Author: mharis001
 * Zeus module function to make an object an IED.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleCreateIED
 *
 * Public: No
 */
#include "script_component.hpp"

#define EXPLOSIVES ["R_TBG32V_F", "M_Mo_120mm_AT", "Bo_GBU12_LGB"]
#define SCANNING_PERIOD 0.5

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NothingSelected)] call EFUNC(common,showMessage);
};

if (!alive _object) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

if (_object isKindOf "CAManBase") exitWith {
    [LSTRING(OnlyNonInfantry)] call EFUNC(common,showMessage);
};

if (_object getVariable [QGVAR(isIED), false]) exitWith {
    [LSTRING(AlreadyAnIED)] call EFUNC(common,showMessage);
};

[LSTRING(CreateIED), [
    ["SIDES", LSTRING(ActivationSide), west],
    ["SLIDER", LSTRING(ActivationRadius), [5, 50, 10, 0]],
    ["COMBO", LSTRING(ExplosionSize), [[0, 1, 2], ["str_small", ELSTRING(common,Medium), "str_large"], 0]],
    ["TOOLBOX:YESNO", LSTRING(IsJammable), false]
], {
    params ["_dialogValues", "_object"];
    _dialogValues params ["_activationSide", "_activationRadius", "_explosionSize", "_isJammable"];

    // Prevent another Create IED module from being attached
    _object setVariable [QGVAR(isIED), true, true];

    [{
        params ["_args", "_pfhID"];
        _args params ["_object", "_activationSide", "_activationRadius", "_explosionSize", "_isJammable"];

        if (isNull _object) exitWith {
            [_pfhID] call CBA_fnc_removePerFrameHandler;
        };

        private _fnc_detonateCondition = {
            private _nearEntities = (_object nearEntities _activationRadius) select {
                side _x == _activationSide
                && {!_isJammable || {!(_x getVariable [QGVAR(hasECM), false])}}
            };
            !(_nearEntities isEqualTo [])
        };

        if (!alive _object || _fnc_detonateCondition) exitWith {
            createVehicle [EXPLOSIVES select _explosionSize, _object, [], 0, "CAN_COLLIDE"];
            [_pfhID] call CBA_fnc_removePerFrameHandler;
        };
    }, SCANNING_PERIOD, [_object, _activationSide, _activationRadius, _explosionSize, _isJammable]] call CBA_fnc_addPerFrameHandler;
}, {}, _object] call EFUNC(dialog,create);
