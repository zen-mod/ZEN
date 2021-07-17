#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns children actions based on grenades in selected AI's inventories.
 *
 * Arguments:
 * 0: Selected Objects <ARRAY>
 *
 * Return Value:
 * Actions <ARRAY>
 *
 * Example:
 * [[_unit1, _unit2]] call zen_context_actions_fnc_getGrenadeActions
 *
 * Public: No
 */

params ["_objects"];

// Get all magazines in the inventories of on foot AI
private _magazines = [];
{
    if (!isPlayer _x && {vehicle _x == _x}) then {
        _magazines append magazines _x;
    };
} forEach _objects;

// Filter out non-grenade magazines, sort alphabetically by display name
private _grenades = _magazines arrayIntersect GVAR(grenadesList) apply {GVAR(grenades) getVariable _x};
_grenades sort true;

private _actions = [];

{
    _x params ["_displayName", "_picture", "_magazine", "_muzzle"];

    private _action = [
        format [QGVAR(%1), _forEachIndex],
        _displayName,
        _picture,
        {[_selectedObjects, _args] call FUNC(selectThrowPos)},
        {true},
        [_magazine, _muzzle]
    ] call EFUNC(context_menu,createAction);

    _actions pushBack [_action, [], 0];
} forEach _grenades;

_actions
