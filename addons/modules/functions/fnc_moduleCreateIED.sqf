/*
 * Author: mharis001
 * Zeus module function to make an object an IED.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Activation side <SIDE>
 * 2: Activation radius <NUMBER>
 * 3: Explosion size (0 - Small, 1 - Medium, 2 - Large) <NUMBER>
 * 4: Is Jammable <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [object, west, 10, 0, true] call zen_modules_fnc_moduleCreateIED
 *
 * Public: No
 */
#include "script_component.hpp"

#define EXPLOSIVES ["R_TBG32V_F", "M_Mo_120mm_AT", "Bo_GBU12_LGB"]
#define SCANNING_PERIOD 0.5

params ["_object"];

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
}, SCANNING_PERIOD, _this] call CBA_fnc_addPerFrameHandler;
