/*
 * Author: 3Mydlo3
 * Heals players in given selection.
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

private _players = _this select {isPlayer _x};

private _moduleGroup = createGroup sideLogic;
{
	private _module = _moduleGroup createUnit [
		QEGVAR(modules,moduleHeal),
		[0, 0, 0],
		[],
		0,
		"CAN_COLLIDE"
	];
	_module attachTo [_x];
	_module setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true];
} forEach _players;
