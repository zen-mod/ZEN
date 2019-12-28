#include "script_component.hpp"
/*
 * Author: mharis001
 * Allows Zeus to select a position to make AI fire artillery at.
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

private _vehicles = _selectedObjects select {
    !isNull gunner _x && {_args in getArtilleryAmmo [_x]}
};

if (_vehicles isEqualTo []) exitwith {};

private _fnc_color = {
    params ["_vehicles", "_position", "_magazine"];

    private _inRange = ASLtoAGL _position inRangeOfArtillery [_vehicles, _magazine];
    [[1, 0, 0, 1], [0, 1, 0, 1]] select _inRange
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
}, _args, LSTRING(FireArtillery), nil, _fnc_color] call EFUNC(common,getTargetPos);
