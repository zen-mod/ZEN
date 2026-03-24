#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns children actions for grenades in unit inventories.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * Actions <ARRAY>
 *
 * Example:
 * [_object] call zen_context_actions_fnc_getGrenadeActions
 *
 * Public: No
 */

// Get all magazines in the inventories of units that can throw grenades
private _magazines = flatten (_this select {
    _x call EFUNC(ai,canThrowGrenade)
} apply {
    magazines _x
});

// Filter out non-grenade magazines and sort them alphabetically by name
private _cache = uiNamespace getVariable QGVAR(grenades);
private _grenades = _magazines arrayIntersect keys _cache apply {
    (_cache get _x) params ["_name", "_icon"];
    [_name, _icon, _x]
};

_grenades sort true;

// Create actions for every grenade type
private _actions = [];

{
    _x params ["_name", "_icon", "_magazine"];

    private _action = [
        _magazine,
        _name,
        _icon,
        {
            [_objects, _args] call FUNC(selectThrowPos);
        },
        {true},
        _magazine
    ] call EFUNC(context_menu,createAction);

    _actions pushBack [_action, [], 0];
} forEach _grenades;

_actions
