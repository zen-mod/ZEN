#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns a list of players based on the given entities.
 *
 * Arguments:
 * 0: Entities <OBJECT|GROUP|SIDE|ARRAY>
 *
 * Return Value:
 * Players <ARRAY>
 *
 * Example:
 * [player] call zen_common_fnc_getPlayers
 *
 * Public: No
 */

params [["_entities", [], [objNull, grpNull, west, []]]];

if !(_entities isEqualType []) then {
    _entities = [_entities];
};

call CBA_fnc_players select {_x in _entities || {group _x in _entities} || {side group _x in _entities}}
