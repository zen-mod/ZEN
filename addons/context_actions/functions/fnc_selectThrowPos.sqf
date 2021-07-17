#include "script_component.hpp"
/*
 * Author: mharis001
 * Allows Zeus to select a position to make AI throw grenades at.
 *
 * Arguments:
 * 0: Selected Objects <ARRAY>
 * 1: Arguments <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[_unit1, _unit2], ["HandGrenade", "HandGrenadeMuzzle"]] call zen_context_actions_fnc_selectThrowPos
 *
 * Public: No
 */

#define MAX_DISTANCE 75

params ["_selectedObjects", "_args"];
_args params ["_magazine", "_muzzle"];

// Get AI units that are alive, on foot, and have the selected grenade type
private _units = _selectedObjects select {
    alive _x
    && {!isPlayer _x}
    && {_x isKindOf "CAManBase"}
    && {vehicle _x == _x}
    && {_magazine in magazines _x}
};

private _text = format [localize LSTRING(ThrowX), getText (configFile >> "CfgMagazines" >> _magazine >> "displayName")];

[_units, {
    params ["_successful", "_units", "_position", "_muzzle"];

    if (!_successful) exitWith {};

    private _notInRange = 0;

    {
        if (_x distance2D _position < MAX_DISTANCE) then {
            [QEGVAR(ai,throwGrenade), [_x, _muzzle, _position], _x] call CBA_fnc_targetEvent;
        } else {
            _notInRange = _notInRange + 1;
        };
    } forEach _units;

    if (_notInRange > 0) then {
        [LSTRING(PositionTooFar), _notInRange] call EFUNC(common,showMessage);
    };
}, _muzzle, _text] call EFUNC(common,getTargetPos);
