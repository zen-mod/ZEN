#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns children actions for available artillery ammo types.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * Actions <ARRAY>
 *
 * Example:
 * _objects call zen_context_actions_fnc_getArtilleryActions
 *
 * Public: No
 */

// Filter vehicles that do not have a gunner
private _vehicles = _this select {!isNull gunner _x};

// Get all artillery magazines for vehicles with gunners
private _cfgMagazines = configFile >> "CfgMagazines";

private _magazines = getArtilleryAmmo _vehicles apply {
    [getText (_cfgMagazines >> _x >> "displayName"), _x]
};

_magazines sort false;

// Create actions for every artillery ammo type
private _actions = [];

{
    _x params ["_displayName", "_magazine"];

    private _action = [_magazine, _displayName, "", LINKFUNC(selectArtilleryPos), {true}, _magazine] call EFUNC(context_menu,createAction);
    _actions pushBack [_action, [], _forEachIndex];
} forEach _magazines;

_actions
