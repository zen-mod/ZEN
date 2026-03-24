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

if (_vehicles isEqualTo []) exitWith {};

private _modifierFunction = {
    params ["_vehicles", "_position", "_magazine", "_visuals"];

    if (ASLToAGL _position inRangeOfArtillery [_vehicles, _magazine]) then {
        _visuals set [0, LSTRING(FireArtillery)];
        _visuals set [3, COLOR_IN_RANGE];
    } else {
        _visuals set [0, LSTRING(UnableToFire)];
        _visuals set [3, COLOR_OUT_OF_RANGE];
    };
};

[_vehicles, {
    params ["_successful", "_vehicles", "_position", "_magazine"];

    if (!_successful) exitWith {};

    _position = ASLToAGL _position;

    if (_position inRangeOfArtillery [_vehicles, _magazine]) then {
        {
            [QEGVAR(common,doArtilleryFire), [_x, _position, _magazine, 4], _x] call CBA_fnc_targetEvent;
        } forEach _vehicles;
    } else {
        [LSTRING(NotAllVehiclesInRange)] call EFUNC(common,showMessage);
    };
}, _args, nil, nil, nil, nil, _modifierFunction] call EFUNC(common,selectPosition);
