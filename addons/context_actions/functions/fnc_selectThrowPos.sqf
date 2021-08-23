#include "script_component.hpp"
/*
 * Author: mharis001
 * Allows Zeus to select a position to make units throw grenades at.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: Magazine <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_objects, "HandGrenade"] call zen_context_actions_fnc_selectThrowPos
 *
 * Public: No
 */

#define MAX_DISTANCE 75

params ["_objects", "_magazine"];

// Get units that can throw the selected grenade type
private _units = _objects select {
    [_x, _magazine] call EFUNC(ai,canThrowGrenade)
};

private _name = getText (configFile >> "CfgMagazines" >> _magazine >> "displayName");
private _text = format [LLSTRING(ThrowX), _name];

[_units, {
    params ["_confirmed", "_units", "_position", "_magazine"];

    if (!_confirmed) exitWith {};

    private _notInRange = 0;

    {
        if (_x distance2D _position <= MAX_DISTANCE) then {
            [_x, _magazine, _position] call EFUNC(ai,throwGrenade);
        } else {
            _notInRange = _notInRange + 1;
        };
    } forEach _units;

    if (_notInRange > 0) then {
        [LSTRING(PositionTooFar), _notInRange] call EFUNC(common,showMessage);
    };
}, _magazine, _text] call EFUNC(common,selectPosition);
