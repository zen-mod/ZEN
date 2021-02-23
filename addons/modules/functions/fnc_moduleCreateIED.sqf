#include "script_component.hpp"
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

#define EXPLOSIVES ["R_TBG32V_F", "M_Mo_120mm_AT", "Bo_GBU12_LGB", "Bo_GBU12_LGB"]
#define SCANNING_PERIOD 0.5

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
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
    ["SLIDER:RADIUS", LSTRING(ActivationRadius), [5, 50, 10, 0, _object, [1, 0, 0, 0.7]]],
    ["TOOLBOX", LSTRING(ExplosionSize), [0, 1, 4, ["str_small", ELSTRING(common,Medium), "str_large", ELSTRING(common,Extreme)]]],
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
            _object nearEntities _activationRadius findIf {
                side group _x == _activationSide && {_x != _object} && {!_isJammable || {!(_x getVariable [QGVAR(hasECM), false])}}
            } != -1
        };

        if (!alive _object || _fnc_detonateCondition) exitWith {
            // Special handling for extreme explosion size
            if (_explosionSize == 3) then {
                private _radius = sizeOf typeOf _object * 1.5;

                for "_angle" from 0 to 360 step 45 do {
                    private _position = ASLToATL AGLToASL (_object getPos [_radius, _angle]);
                    createVehicle [EXPLOSIVES select _explosionSize, _position, [], 0, "CAN_COLLIDE"];
                };
            };

            createVehicle [EXPLOSIVES select _explosionSize, _object, [], 0, "CAN_COLLIDE"];

            // Manually destroy the IED object since some objects do not get destroyed by the explosion
            // And it would be expected that the object does not survive the explosion
            if (alive _object) then {
                _object setDamage 1;
            };

            [_pfhID] call CBA_fnc_removePerFrameHandler;
        };
    }, SCANNING_PERIOD, [_object, _activationSide, _activationRadius, _explosionSize, _isJammable]] call CBA_fnc_addPerFrameHandler;
}, {}, _object] call EFUNC(dialog,create);
