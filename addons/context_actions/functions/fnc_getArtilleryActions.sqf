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
 * [_object] call zen_context_actions_fnc_getArtilleryActions
 *
 * Public: No
 */

// Get artillery magazines for vehicles with gunners
private _vehicles = _this select {!isNull gunner _x};
private _cfgMagazines = configFile >> "CfgMagazines";

private _magazines = getArtilleryAmmo _vehicles apply {
    [getText (_cfgMagazines >> _x >> "displayName"), _x]
};

_magazines sort true;

// Create actions for every artillery ammo type
private _actions = [];

{
    _x params ["_name", "_magazine"];

    private _action = [_magazine, _name, QPATHTOF(ui\ammo_ca.paa), FUNC(selectArtilleryPos), {true}, _magazine] call EFUNC(context_menu,createAction);
    _actions pushBack [_action, [], 0];
} forEach _magazines;

_actions
