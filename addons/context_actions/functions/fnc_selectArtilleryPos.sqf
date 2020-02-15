#include "script_component.hpp"
/*
 * Author: mharis001
 * Allows Zeus to select a position to fire artillery at.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_context_actions_fnc_selectArtilleryPos
 *
 * Public: No
 */

#define COLOR_IN_RANGE [0, 0.9, 0, 1]
#define COLOR_OUT_OF_RANGE [0.9, 0, 0, 1]

private _vehicles = _objects select {
    !isNull gunner _x && {_args in getArtilleryAmmo [_x]}
};

if (_vehicles isEqualTo []) exitwith {};

private _fnc_modifier = {
    params ["_vehicles", "_position", "_magazine", "_drawArgs"];

    if (ASLtoAGL _position inRangeOfArtillery [_vehicles, _magazine]) then {
        _drawArgs set [0, LSTRING(FireArtillery)];
        _drawArgs set [3, COLOR_IN_RANGE];
    } else {
        _drawArgs set [0, LSTRING(UnableToFire)];
        _drawArgs set [3, COLOR_OUT_OF_RANGE];
    };
};

[_vehicles, {
    params ["_successful", "_vehicles", "_position", "_magazine"];

    if (!_successful) exitWith {};

    _position = ASLtoAGL _position;

    if (_position inRangeOfArtillery [_vehicles, _magazine]) then {
        {
            [QEGVAR(common,doArtilleryFire), [_x, _position, _magazine, 4], _x] call CBA_fnc_targetEvent;
        } forEach _vehicles;
    } else {
        [LSTRING(NotAllVehiclesInRange)] call EFUNC(common,showMessage);
    };
}, _args, nil, nil, nil, _fnc_modifier] call EFUNC(common,selectPosition);
