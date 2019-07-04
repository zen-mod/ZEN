/*
 * Author: 3Mydlo3
 * Heals players in given selection. Works for players in vehicles.
 *
 * Arguments:
 * N: Selected Objects <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player1, player2, player3] call zen_context_actions_fnc_healPlayers
 *
 * Public: No
 */
#include "script_component.hpp"

private _mans = [];
{
	_mans append crew _x;
} forEach _this;

{
	[_x] call EFUNC(common,healUnit);
} forEach _mans select {isPlayer _x};
